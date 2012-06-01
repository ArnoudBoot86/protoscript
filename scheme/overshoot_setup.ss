;overshoot_setup
;Provides procedures for configuring ec100 to measure overshoot problems

#lang scheme
(require scheme/tcp)
;See the plt-scheme documentation for bindings provided by scheme/tcp
;http://docs.plt-scheme.org/reference/tcp.html
;I use tcp-connect


;The ec100's IP address
;Unit 1: 172.25.128.112
;Unit 2: 172.25.128.113
;Unit 3: 172.25.128.114
;Unit 4: 172.25.128.115
;Unit 5: 172.25.128.116
(define IP "172.25.128.115");The ec100's IP address
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

;Read back data, if there is any
(define readback
  (lambda ()
    (if (char-ready? ip) (display (read ip)) (display "No data"))
    (clearq)))

;Get rid of any string terminators, like carriage return or newline    
(define clearq
  (lambda ()
    (cond
      ((char-ready? ip) (read-char ip) (clearq)))))


;The initialization procedure for overshoot measurements
;To use it, just type (overconf)
(define overconf
  (lambda ()
    (sndcmd "IRANGE 4");Set current range to 1mA
    (sndcmd "$CELIM 0");Disable CE limiting
    ;Set +30V compliance limit
    ;Unit 4: ce0    
    (sndcmd "$clmph ce0");Set 30V compliance limit
    ;Set -30V compliance limit
    ;Unit 4: d33
    (sndcmd "$clmpl d33");Set -30V compliance limit
    (sndcmd "CLBWTH 1");Set control bandwidth to 1MHz
    (sndcmd "CEENAB 1");Close AC switch
    (sndcmd "ECMODE 0");Set potentiostat mode
    (sndcmd "$EIGAI 7ff");Set external input gain to midscale
    ;Current interrupt boost DAC
    ;Unit 4: 0x7fff
    (sndcmd "$BOOST 7fff");Set current interrupt boost DAC
    ;External input offsets:
    ;Unit 4: 0x711
    (sndcmd "$eioff 711");Set external input offset
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