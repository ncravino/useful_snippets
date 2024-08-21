##############################################################################
##############################################################################
####### Documents .PHONY targets 
########## Tested with mawk, gawk, and busybox awk
########## Put the description in a comment starting with ##~ before .PHONY 
########## See example makefile in this repo:
############ https://github.com/ncravino/useful_snippets
##############################################################################
##############################################################################

/^##~/{
    split($0,desc_vec,"~");
    desc = desc_vec[2];
    next;
    }
/^.PHONY:/{
    split($0,target_vec,":");
    target = target_vec[2];
    if(desc)
        printf "\033[33m%-20s\033[0m %s\n", target, desc;
        desc=""     
}


