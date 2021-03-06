function! Autogit()
python << EOF
import vim
import commands
import time

vim.command("w")
cur_f_name = vim.eval("expand('%:p')")
cur_s_time = vim.eval("strftime('%Y-%d-%m %H:%M')")
status, result_1 = commands.getstatusoutput("git add " + cur_f_name)
status_1, result_1 = commands.getstatusoutput("git commit -a -m " + "'"+ cur_s_time +"'")
if status and status_1 != 0:
        #print "git commit fail, please check your .git"
        print status
else:
        vim.command("echo 'git commit success at " + cur_s_time + "'")
EOF
endfunction
noremap <F2> :call Autogit()<cr>
