# tools
Misc tools like shell scripts and small compiled programs

## args_parsing.sh
180318  

Sample POSIX (bourne /bin/sh) shell script which parses arguments, both short (`-a`) and long (`--a-long-argument`).  
Can have flags which do not have addition value (`-v`) and flags which have (`--file <non optional filename>`).  

### Test it
*Should work*:  
`./args_parsing.sh --a-long-argument 5`  
`./args_parsing.sh -v -f file-a  --verbose`  

*Should not work*:  
`./args_parsing.sh -v -f file-a  --verbose --sdf`  
`./args_parsing.sh -f --verbose`  
`./args_parsing.sh -f -v`  
`./args_parsing.sh --a-long-argument`  
