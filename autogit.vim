function! Autogit()
python << EOF
import vim
import commands
import time
cur_f_name = vim.eval("expand('%:p')")
status, result_1 = commands.getstatusoutput("git add " + cur_f_name)
status_1, result_1 = commands.getstatusoutput("git commit -a -m 'autogit'")
status_1, result_w = commands.getstatusoutput("pwd")
print result_w
if status and status_1 != 0:
        #print "git commit fail, please check your .git"
        print status
print vim_cur_buff
EOF
endfunction
