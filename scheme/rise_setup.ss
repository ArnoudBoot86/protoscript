
;Provides procedures for configuring ec100 for rise time measurements

#lang scheme
(require scheme/tcp)
;See the plt-scheme documentation for bindings provided by scheme/tcp
;http://docs.plt-scheme.org/reference/tcp.html
;I use tcp-connect

(define IP "172.25.128.112");The ec100's IP address
(define PORT 1680);Port the ec100 is listening to
(define TERM "\r\n");The command terminator

;Connect to the ec100 by setting up input and output ports
(define-values (ip op) (tcp-connect IP PORT))



;The sndcmd procedure formats a command to be sent to the ec100.
;Example: (sndcmd "IRANGE 3")
;You must flush or close the output port to send the data over
;the wire using (flush-output op) or (close-output-port op)
(define sndcmd
  (lambda (cmdstring) (fprintf op "~a~a" cmdstring TERM)))


;If you just want to send one command
(define onecmd
  (lambda (cmdstring)
    (sndcmd cmdstring)
    (flush-output op)))


;The initialization procedure for rise time measurements
;To use it, just type (riseconf)
(define riseconf
  (lambda ()
    (sndcmd "IRANGE 4");Set current range to 1mA
    (sndcmd "$CELIM 0");Disable CE limiting
    (sndcmd "CLBWTH 1");Set control bandwidth to 1MHz
    (sndcmd "CEENAB 1");Close AC switch
    (sndcmd "ECMODE 0");Set potentiostat mode
    (sndcmd "$EIGAI 7ff");Set external input gain to midscale
    (sndcmd "$BOOST 7fa0");Set current interrupt boost DAC
    (sndcmd "$EIOFF 9c0");Set external input offset
    (sndcmd "$EIENA 1");Enable external input
    (sndcmd "$RAWEO 7ff");Set raw E offset
    (sndcmd "$RPEGN cff");Set rear-panel E gain
    (sndcmd "BIREJE 7fff");Set front-panel E bias reject
    (sndcmd "$FPEGN cff");Set front panel E gain
    (sndcmd "$I2VOF 980");Set raw I/V offset
    (sndcmd "BIREJI 808");Set front panel I bias reject
    (flush-output op)))

;Use this to disable control 
(define release
  (lambda ()
    (sndcmd "ECMODE 3");Set local feedback
    (sndcmd "CEENAB 0");Open AC switch
    (flush-output op)))