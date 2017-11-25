#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     ._______auto_sync_by_GIT__in_crontab.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 14:34:27
#   ModifiedTime: 2017-11-15 14:40:00

JLLCFG_RemoteGit_URL="https://github.com/linjielong/linux/commits/master"

if [ x"$(which w3m)" = x ]; then
    apt-get install -y w3m
fi

# _FN_retrieve_git_commits_by_GitURL
function _FN_retrieve_git_commits_by_GitURL()
{
    if [ x"$1" = x ]; then
        echo
        echo "JLL-return:: unknown Git URL parameter $1"
        echo
        return
    fi
    __HtmlFile=.git_commits.html
    echo
    echo "JLL-network:: w3m $1"
    w3m $1 > ${__HtmlFile}
    echo
    echo "JLL-response:: parsing response for retrieving all git commits"
    echo
    __CTXLine="$(cat ${__HtmlFile} \
               | grep -n -A 1 -E '^[ \t]{0,}.*[ \t]{1,}committed[ \t]{1,}' --color=never)"
    rm -rf ${__HtmlFile} 2>/dev/null

    OldIFS="${IFS}"
    IFS=$'\n'
    for __CTXLn in ${__CTXLine}; do
        __CTXL=$(echo "${__CTXLn}" | grep -E '^[0-9]{1,}-[ \t]{1,}[0-9a-fA-F]{7,}')
        if [ x"${__CTXL}" != x ]; then
            __lstCommittedIDs[__iCommittedIDs++]="${__CTXL##* }"
        fi
    done
    IFS="${OldIFS}"

    for((__i=0;__i<__iCommittedIDs;__i++)) {
        echo "JLL-descend:: commit.id=${__lstCommittedIDs[__i]}"
    }

    [ x"${__CTXLine}" != x ] && unset __CTXLine
}

function _FN_is_align_with_git_remote()
{
    if [ x"${__iCommittedIDs}" != x -a ${__iCommittedIDs} -gt 0 ]; then
        __local_commitID=$(git log --oneline | head -n 1)
        __local_commitID="${__local_commitID%% *}"
        if [ x"${__local_commitID}" != x ]; then
            __isReturn=0
            echo "JLL-check:: local.lastest.commit.id --- remote.commit.id "
            for((__k=0;__k<__iCommittedIDs;__k++)) {
                echo "JLL-check:: ${__local_commitID} --- ${__lstCommittedIDs[__k]}"
                if [ x"${__local_commitID}" = x"${__lstCommittedIDs[__k]}" ]; then
                    __isReturn=1
                    echo "JLL-check:: HIT at ${__local_commitID} --- ${__lstCommittedIDs[__k]}"
                    break
                fi
            }
            if [ x"${__isReturn}" = x"1" -a x"$1" != x ]; then
                if [ x"${__local_commitID}" != x"${__lstCommittedIDs[0]}" ]; then
                    eval $1=1
                    return
                fi
                eval $1=0  # Has already aligned
                return
            fi
        fi
    fi
    if  [ x"$1" != x ]; then # other cases should be best to align.
        eval $1=1
    fi
}



#The below variables are set by __SSHCONF_GetCommiter
__JLLCONF_Committer_Author=jielong.lin
__JLLCONF_Committer_Email=jielong.lin@qq.com


__ssh_package=.__ssh_R$(/bin/date +%Y_%m_%d__%H_%M_%S)
function __SSHCONF_Switching_Start__linjielong()
{
    /bin/echo
    if [ -e "${HOME}/.ssh" ]; then
        /bin/echo "JLL: ~/.ssh will be moved to ${__ssh_package}"
        /bin/mv -fv ${HOME}/.ssh  ${HOME}/${__ssh_package}
        /bin/echo
    fi
    /bin/mkdir -pv ${HOME}/.ssh
    /bin/chmod 0777 ${HOME}/.ssh
    /bin/echo "JLL: Generate ~/.ssh/id_rsa belong to 1624646454@qq.com"
/bin/cat >${HOME}/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
EOF
    /bin/chmod 0400 ${HOME}/.ssh/id_rsa
/bin/cat >${HOME}/.ssh/known_hosts<<EOF
|1|EQctxEsmYK/85uu2fpaX38B+OGU=|lJmTjsoNzWyaxiBwxmjWxGMfY28= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|1UQS7ifWyS7kYvWVZS/hVoP2I48=|IdcpGM0L2v6l1f6NEdmpNY89dDc= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|e9sU4Tu3Xrvl5qtsWsqclSJqOXY=|H424klNFv7JN/+IMCWqlRUOrB9s= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
EOF
    /bin/chmod 0644 ${HOME}/.ssh/known_hosts
    /bin/echo
}

function __SSHCONF_Switching_End()
{
    if [ -e "${HOME}/${__ssh_package}" ]; then
        if [ -e "${HOME}/.ssh" ]; then
            /bin/rm -rvf ${HOME}/.ssh
        fi
        /bin/mv -vf ${HOME}/${__ssh_package}  ${HOME}/.ssh
        /bin/echo "JLL: Finish restoring the original ssh configuration."
    else
        /bin/echo "JLL: Nothing to do for restoring the original ssh configuration."
    fi
}

function __IsGIT()
{
    if [ $# -ne 1 ]; then
        echo
        echo "JLL: Exit due to function prototype error! - __IsGIT <parameter>"
        echo
        exit 0
    fi

    __RawCTX=$(git remote show origin | grep -E "^[ ]{0,}Push[ ]{1,}URL:[ ]{0,}https:")
    if [ x"${__RawCTX}" = x ]; then
        __RawCTX=$(git remote show origin | grep -E "^[ ]{0,}Push[ ]{1,}URL:[ ]{0,}git@")
        if [ x"${__RawCTX}" = x ]; then
            echo
            echo "JLL: Exit due to unknown scheme such as git@ or https://"
            echo
            exit 0 
        fi
        # start with git@
        eval $1=1
        return
    fi
    # start with https:// 
    eval $1=0
    return
}



JLLPATH="$(/usr/bin/which $0)"
JLLPATH="$(/usr/bin/dirname ${JLLPATH})"
JLLPATH=$(cd ${JLLPATH} >/dev/null;pwd)
JLLSELF="$(/usr/bin/basename ${JLLPATH})"
if [ x"${JLLSELF}" = x ]; then
    JLLSELF=$(/bin/pwd)
    JLLSELF="$(/usr/bin/basename ${JLLSELF})"
    [ x"${JLLSELF}" = x ] && JLLSELF=unknown
fi

__DT=$(/bin/date +%Y-%m-%d_%H:%M:%S)

if [ ! -e "${JLLPATH}/.git" ]; then
    /bin/echo
    /bin/rm -rf ${HOME}/cron.*.log
    /bin/echo
    /bin/echo "JLL: Error because not present \"${JLLPATH}/.git\"" > ${HOME}/cron.${JLLSELF}@${__DT}.log 
    /bin/echo "JLL: FOR ${JLLSELF}" >> ${HOME}/cron.${JLLSELF}@${__DT}.log 
    /bin/echo
    /bin/exit 0
fi

cd ${JLLPATH}

__RemoteRepository=$(/usr/bin/git remote show origin | /bin/grep -E '^[ ]{0,}Push[ ]{1,}URL:')
__RemoteRepository=${__RemoteRepository#*:}
[ x"${__RemoteRepository}" = x ] && __RemoteRepository="remote.${JLLSELF}"

/bin/echo "synchronizing with ${__RemoteRepository} @${__DT}"        >  _______auto_sync_by_GIT__in_crontab.log
__GitCHANGE="$(/usr/bin/git status -s)"
if [ x"${__GitCHANGE}" != x ]; then
  __IsGIT __IsEnter
  if [ ${__IsEnter} -eq 1 ]; then

declare -a __lstCommittedIDs
declare -i __iCommittedIDs=0
_FN_retrieve_git_commits_by_GitURL  "${JLLCFG_RemoteGit_URL}" \
                                                                     >> _______auto_sync_by_GIT__in_crontab.log
_FN_is_align_with_git_remote __isAlign  \
                                                                     >> _______auto_sync_by_GIT__in_crontab.log
[ x"${__lstCommittedIDs}" != x ] && unset __lstCommittedIDs
[ x"${__iCommittedIDs}" != x ] && unset __iCommittedIDs

    /usr/bin/git config --global user.email ${__JLLCONF_Committer_Email}
    /usr/bin/git config --global user.name  ${__JLLCONF_Committer_Author}

if [ x"${__isAlign}" = x"1" ]; then
/bin/echo "Found the latest changes in ${__RemoteRepository}"        >> _______auto_sync_by_GIT__in_crontab.log
/bin/echo "First Pull Changes from '${__RemoteRepository}' by git pull before git push -f "  \
                                                                     >> _______auto_sync_by_GIT__in_crontab.log
/usr/bin/git pull -f -u origin master                                >> _______auto_sync_by_GIT__in_crontab.log
fi

    /usr/bin/git status -s                                           >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git add    -A                                           >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git commit -m \
"
Changes as follows: 
${__GitCHANGE}
"                                                                    >> _______auto_sync_by_GIT__in_crontab.log
    /bin/echo                                                        >> _______auto_sync_by_GIT__in_crontab.log
    __SSHCONF_Switching_Start__linjielong
    /bin/echo "Push Changes to '${__RemoteRepository}' by git push"  >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git push -f                                             >> _______auto_sync_by_GIT__in_crontab.log
    __SSHCONF_Switching_End
    /usr/bin/git status -s                                           >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git log -4                                              >> _______auto_sync_by_GIT__in_crontab.log
    /bin/echo                                                        >> _______auto_sync_by_GIT__in_crontab.log
  fi
fi


declare -a __lstCommittedIDs
declare -i __iCommittedIDs=0

_FN_retrieve_git_commits_by_GitURL \
     "${JLLCFG_RemoteGit_URL}"                                        >> _______auto_sync_by_GIT__in_crontab.log
_FN_is_align_with_git_remote __isAlign  \
                                                                     >> _______auto_sync_by_GIT__in_crontab.log
[ x"${__lstCommittedIDs}" != x ] && unset __lstCommittedIDs
[ x"${__iCommittedIDs}" != x ] && unset __iCommittedIDs

/bin/echo                                                            >> _______auto_sync_by_GIT__in_crontab.log
/bin/echo "Check if align with remote via __isAlign=${__isAlign}"    >> _______auto_sync_by_GIT__in_crontab.log
if [ x"${__isAlign}" = x"1" ]; then
/bin/echo "Pull Changes from '${__RemoteRepository}' by git pull "   >> _______auto_sync_by_GIT__in_crontab.log
/usr/bin/git pull -f -u origin master                                >> _______auto_sync_by_GIT__in_crontab.log
fi
/usr/bin/git log  -4                                                 >> _______auto_sync_by_GIT__in_crontab.log
/bin/echo                                                            >> _______auto_sync_by_GIT__in_crontab.log
cd - >/dev/null

