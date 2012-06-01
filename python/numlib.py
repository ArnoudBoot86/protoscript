# numlib.py
# Number-related functions

# binvert(number)
# Takes a number and inverts its binary representation bit by bit. 
# Returns a number not converted using two's complement.  For example:
# binvert(4) returns 3
def binvert(number):
    outlist = []
    instring = bin(number) # Convert to binary string
    instring = instring[2:] # Get rid of the 0b part
    for bit in instring:
        if bit == '1':
            outlist.append('0')
        elif bit == '0':
            outlist.append('1')
    outstring = ''.join(outlist)
    outnum = int(outstring,2)
    return outnum
    
    
# bitset(number,position)
# Sets the bit at position (0 position is lsb)
def bitset(number,position):
    outlist = []
    instring = bin(number) # Convert to binary string
    instring = instring[2:] # Get rid of the 0b part
    for bit in instring:
        outlist.append(bit)
    while len(outlist) < (position + 1): # Pad up to position
        outlist.insert(0,'0')
    outlist[len(outlist) - 1 - position] = '1'
    outstring = ''.join(outlist)
    outnum = int(outstring,2)
    return outnum
    
# bitclear(number,position)
# Clears the bit at position (0 position is lsb)
def bitclear(number,position):
    outlist = []
    instring = bin(number) # Convert to binary string
    instring = instring[2:] # Get rid of the 0b part
    for bit in instring:
        outlist.append(bit)
    while len(outlist) < (position + 1): # Pad up to position
        outlist.insert(0,'0')
    outlist[len(outlist) - 1 - position] = '0'
    outstring = ''.join(outlist)
    outnum = int(outstring,2)
    return outnum
        
# bitog(number,position)
# Toggles the bit at position (0 position is lsb)
def bitog(number,position):
    outlist = []
    instring = bin(number) # Convert to binary string
    instring = instring[2:] # Get rid of the 0b part
    for bit in instring:
        outlist.append(bit)
    while len(outlist) < (position + 1): # Pad up to position
        outlist.insert(0,'0')
    if outlist[len(outlist) - 1 - position] == '0':
        outlist[len(outlist) - 1 - position] = '1'
    else:
        outlist[len(outlist) - 1 - position] = '0'
    outstring = ''.join(outlist)
    outnum = int(outstring,2)
    return outnum
            
