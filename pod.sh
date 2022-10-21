
#【脚本使用方法：将脚本放在源码同级目录下,执行 sh pod.sh 即可】
# iOS_Foka
# pod.sh

RootPath=`pwd`

# 组件工程路径
ZiRoomProjectPath=$RootPath
#个人主目录（操作个人资源需修改此目录）
MasterCatalogue="/Users/wxq"

# repo仓库路径
ZRModuleSpec="https://gitlab.ziroom.com/wireless-architect/architect-ios/ZRModuleSpec.git"
ZRModuleSpec_test="https://gitlab.ziroom.com/wireless-architect/architect-ios/ZRModuleSpec_test.git"
ZROtherModuleSpec="https://gitlab.ziroom.com/wireless-architect/architect-ios/ZROtherModuleSpec.git"
ZRCodeMoudleSpec="https://code.ziroom.com/wireless-architect-ios/ZRMoudleSpec.git"
ZRCodeMoudleSpec_test="https://code.ziroom.com/wireless-architect-ios/ZRMoudleSpec_test.git"
ZRCodeOtherMoudleSpec="https://code.ziroom.com/wireless-architect-ios/ZROtherMoudleSpec.git"

# 全部操作
Handle_Status="查看代码status（暂不可用）"
Handle_PodHandle="Pod操作"
Handle_Pull="更新"
Handle_Push="提交（暂不可用）"
Handle_Branch="分支操作（暂不可用）"
Handle_OpenPath="打开工程"
Handle_OpenFile="打开文件夹"
Handle_image_manager2="执行image_manager2"
Handle_Clone="Clone代码"

Handle_Exit="0. 退出"
Handle_Back="0. 返回上一级"
SEPARATE_LINE="========================================="
Remind_Error="!!!输入错误，请重新输入!!!"

function getHandleArr()
{
    HandleArr=(
        $Handle_PodHandle
        $Handle_Pull
        $Handle_Push
        $Handle_Branch
        $Handle_OpenPath
        $Handle_OpenFile
        $Handle_image_manager2
        $Handle_Clone
        $Handle_Status
    )
}

# 全部组件
iOS_Foka="iOS_Foka"
iOS_ServiceModule="iOS_ServiceModule"
iOS_ServiceMap="iOS_ServiceMap"
ios_serviceplatform="ios_serviceplatform"
iOS_ServiceUI="iOS_ServiceUI"
ziroom_client_ios="ziroom-client-ios"
iOS_Clean="iOS_Clean"
iOS_Move="iOS_Move"
ZRRouterDefine="ZRRouterDefine"
ZRRouterModule="ZRRouterModule"
ZUX="ZUX"

function getModule_Foka()
{
    Module_Foka=(
        iOS_Foka
        iOS_ServiceModule
        iOS_ServiceMap
        ios_serviceplatform
        iOS_ServiceUI
        ziroom_client_ios
        iOS_Clean
        iOS_Move
        ZRRouterDefine
        ZRRouterModule
        ZUX
    )
}

# 打开文件夹
File_Master="打开主目录"
File_Shell="打开脚本文件夹"
File_CocoaPods="打开.cocoapods"
File_bash_profile="打开.bash_profile"
File_gitconfig="打开.gitconfig"

function getFileArray()
{
    FileArray=(
        $File_Master
        $File_Shell
        $File_CocoaPods
        $File_bash_profile
        $File_gitconfig
    )
}

#function getAllModules()
#{
#    echo "getAllModules"
#    getModule_Foka
#    ModuleArr_All=(
#        ${Module_Foka[@]}
##        ${ModuleArr_Foundation[@]}
#    )
#}

###################### 公共方法 ######################
# 打印当前目录
function PrintCurrentRootPath()
{
#    echo "\033[0;32;1m当前目录：$RootPath \033[0m"
    echo "\033[0;32;1m当前目录：$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) \033[0m"
}
# 打印指定目录
function PrintAppointRootPath()
{
    AppointRoot=$1
    echo "\033[0;32;1m当前目录：$AppointRoot \033[0m"
}
# 请输入你的选项
function PleaseInputYourSelect()
{
    echo "\033[0;31;1m请输入你的选项： \033[0m"
}
# 请选择你要操作的工程
function PleaseSelectOperateProject()
{
    echo "\033[0;31;1m请选择你要操作的工程： \033[0m"
}
# 请输入对应的地址
function PleaseInputAddress()
{
    echo "\033[0;31;1m请输入地址： \033[0m"
}
#错误提示
function remindError()
{
    echo "\033[0;31;1m $Remind_Error \033[0m"
}

function getCodePath()
{
    relativeCodePath=`getProjectValueWithKey ${1}:CodePath`
    CodePath=$RootPath/$relativeCodePath
    echo $CodePath
}

###################### 1. Pod操作 ######################
# pod操作
Pod_Update_No_Repo_Update="Pod_Update_No_Repo_Update"
Pod_Install="Pod_Install"
Pod_Install_Framework="Pod_Install_Framework"
Pod_Update="Pod_Update"
Pod_Update_No_Repo_Update_Verbose="Pod_Update_No_Repo_Update_Verbose"
Pod_Repo_Update="Pod_Repo_Update"
Pod_Add_ZiRoomRepo="添加自如repo仓库"

PodHandleArr=(
    $Pod_Update
    $Pod_Update_No_Repo_Update
    $Pod_Update_No_Repo_Update_Verbose
    $Pod_Install
#    $Pod_Install_Framework
    $Pod_Repo_Update
    $Pod_Add_ZiRoomRepo
)

# ZiRoom Pod Update
function ZiRoomPodHandle()
{
    podHandleCount=${#PodHandleArr[@]}
    for((i=1;i<=$podHandleCount;i++));
    do
        echo $i. ${PodHandleArr[$i -1 ]}
    done

    echo $Handle_Back
    echo $SEPARATE_LINE
    PleaseInputYourSelect

    read podNum
    echo $SEPARATE_LINE

    if [[ $podNum -eq 0 ]];then
        echo "$SEPARATE_LINE  返回上一级 $SEPARATE_LINE"
        break
    elif  (( "$podNum" <= "$podHandleCount" ));then
        podHandle=${PodHandleArr[$podNum - 1]}
        echo "$SEPARATE_LINE  执行$podHandle $SEPARATE_LINE"

        if [[ $podHandle == $Pod_Update_No_Repo_Update ]];then
            handleProject
            cd $podfilePath
            PrintCurrentRootPath
            AddRepoZiRoom
            UpdateRepoZiRoom
            pod update --no-repo-update
        elif [[ $podHandle == $Pod_Update_No_Repo_Update_Verbose ]];then
            handleProject
            cd $podfilePath
            PrintCurrentRootPath
            AddRepoZiRoom
            UpdateRepoZiRoomVerbose
            pod update --no-repo-update --verbose
        elif [[ $podHandle == $Pod_Install ]];then
            handleProject
            cd $podfilePath
            PrintCurrentRootPath
            pod install --verbose
        elif [[ $podHandle == $Pod_Install_Framework ]];then
            handleProject
            cd $podfilePath
            PrintCurrentRootPath
            AddRepoZiRoom
            UpdateRepoZiRoom
            echo 'use_lib=1'
            use_lib=1 pod install --verbose
        elif [[ $podHandle == $Pod_Update ]];then
            handleProject
            cd $podfilePath
            PrintCurrentRootPath
            rm -rf Podfile.lock
            pod update  --verbose
        elif [[ $podHandle == $Pod_Repo_Update ]];then
            pod repo update --verbose
        elif [[ $podHandle == $Pod_Add_ZiRoomRepo ]];then
            AddRepoZiRoom
        else
            echo "!!!输入错误，请重新输入!!!"
            echo "!!!输入错误，请重新输入!!!"
        fi
        cd $RootPath
        echo "$SEPARATE_LINE  执行$podHandle 完成 $SEPARATE_LINE"
    else
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
    fi
}

function handleProject()
{
    echo $SEPARATE_LINE
    getModule_Foka
    FokaModuleCount=${#Module_Foka[@]}
    for((i=1;i<=$FokaModuleCount;i++));
    do
        echo $i. ${Module_Foka[$i -1 ]}
    done

    echo $Handle_Back
    echo $SEPARATE_LINE
    PleaseSelectOperateProject
    
    read number
    if [[ $number -eq 0 ]];then
        echo "$SEPARATE_LINE  返回上一级 $SEPARATE_LINE"
        break
    elif (( "$number" <= "$FokaModuleCount" ));then
        handle=${Module_Foka[$number - 1]}
        echo "$SEPARATE_LINE  执行$handle $SEPARATE_LINE"
    
            if [[ $handle == iOS_Foka ]]; then
                podfilePath=$ZiRoomProjectPath/iOS_Foka/Example
                yourSelectProject=iOS_Foka
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == iOS_ServiceModule ];then
                podfilePath=$ZiRoomProjectPath/iOS_ServiceModule/Example
                yourSelectProject=iOS_ServiceModule
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == iOS_ServiceUI ];then
                podfilePath=$ZiRoomProjectPath/iOS_ServiceUI/Example
                yourSelectProject=iOS_ServiceUI
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == iOS_ServiceMap ];then
                podfilePath=$ZiRoomProjectPath/iOS_ServiceMap/ZRServiceMap
                yourSelectProject=iOS_ServiceMap
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == ios_serviceplatform ];then
                podfilePath=$ZiRoomProjectPath/ios_serviceplatform/Example
                yourSelectProject=ios_serviceplatform
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == ziroom_client_ios ];then
                podfilePath=$ZiRoomProjectPath/ziroom-client-ios
                yourSelectProject=ziroom_client_ios
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == iOS_Clean ];then
                podfilePath=$ZiRoomProjectPath/iOS_Clean/ZRClean
                yourSelectProject=iOS_Clean
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == iOS_Move ];then
                podfilePath=$ZiRoomProjectPath/iOS_Move/ZRMove
                yourSelectProject=iOS_Move
                echo "你的选择为：$yourSelectProject"
            elif [ $handle == ZRRouterDefine ];then
                podfilePath=$ZiRoomProjectPath/ZRRouterDefine
                yourSelectProject=ZRRouterDefine
                echo "你的选择为：$yourSelectProject 无Podfile"
            elif [ $handle == ZRRouterModule ];then
                podfilePath=$ZiRoomProjectPath/ZRRouterModule
                yourSelectProject=ZRRouterModule
                echo "你的选择为：$yourSelectProject 无Podfile"
            elif [ $handle == ZUX ];then
                podfilePath=$ZiRoomProjectPath/ZUX
                yourSelectProject=ZUX
                echo "你的选择为：$yourSelectProject"
            else
                echo "!!!输入错误，请重新输入!!!"
                echo "!!!输入错误，请重新输入!!!"
            fi

    else
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
    fi
}

function UpdateRepoZiRoom(){
    pod repo update ziroom-wireless-architect-architect-ios-zrmodulespec
    pod repo update ziroom-wireless-architect-architect-ios-zrmodulespec_test
    pod repo update ziroom-wireless-architect-architect-ios-zrothermodulespec
#    pod repo update ziroom-wireless-architect-ios-zrmoudlespec
#    pod repo update ziroom-wireless-architect-ios-zrmoudlespec_test
#    pod repo update ziroom-wireless-architect-ios-zrothermoudlespec
}

function UpdateRepoZiRoomVerbose(){
    pod repo update ziroom-wireless-architect-architect-ios-zrmodulespec --verbose
    pod repo update ziroom-wireless-architect-architect-ios-zrmodulespec_test --verbose
    pod repo update ziroom-wireless-architect-architect-ios-zrothermodulespec --verbose
#    pod repo update ziroom-wireless-architect-ios-zrmoudlespec --verbose
#    pod repo update ziroom-wireless-architect-ios-zrmoudlespec_test --verbose
#    pod repo update ziroom-wireless-architect-ios-zrothermoudlespec --verbose
}

function AddRepoZiRoom()
{
    AddRepoSingle "ziroom-wireless-architect-architect-ios-zrmodulespec" "$HOME/.cocoapods/repos/ziroom-wireless-architect-architect-ios-zrmodulespec" "$ZRModuleSpec"
    AddRepoSingle "ziroom-wireless-architect-architect-ios-zrmodulespec_test" "$HOME/.cocoapods/repos/ziroom-wireless-architect-architect-ios-zrmodulespec_test" "$ZRModuleSpec_test"
    AddRepoSingle "ziroom-wireless-architect-architect-ios-zrothermodulespec" "$HOME/.cocoapods/repos/ziroom-wireless-architect-architect-ios-zrothermodulespec" "$ZROtherModuleSpec"
#    AddRepoSingle "ziroom-wireless-architect-ios-zrmoudlespec" "$HOME/.cocoapods/repos/ziroom-wireless-architect-ios-zrmoudlespec" "$ZRCodeMoudleSpec"
#    AddRepoSingle "ziroom-wireless-architect-ios-zrmoudlespec_test" "$HOME/.cocoapods/repos/ziroom-wireless-architect-ios-zrmoudlespec_test" "$ZRCodeMoudleSpec_test"
#    AddRepoSingle "ziroom-wireless-architect-ios-zrothermoudlespec" "$HOME/.cocoapods/repos/ziroom-wireless-architect-ios-zrothermoudlespec" "$ZRCodeOtherMoudleSpec"
}

function AddRepoSingle(){

    temp=$HOME/.PodRepoList.text
    pod repo list >$temp

    addRepoName=$1
    addRepoPath=$2
    addRepoURL=$3
    rename=true
    repoExist=0
    while read line
    do
        if [ $rename == false ];then
            pre="- URL: "
            if [[ "$line"  =~ $pre ]];then
                rename=true
                if [ "$line" == "- URL:  $addRepoURL" ];then
                    echo "URL正确,无需处理"
                else
                    echo "URL不正确,需要删除并添加正确的repo仓库地址"
#                    rm -rf $addRepoPath
#                    pod repo add $addRepoName $addRepoURL
                    echo " $addRepoName Repo已添加成功"
                fi
            fi
        fi
    
        if [ "$line" == "$addRepoName" ];then
            echo " $addRepoName Repo存在,判断URL是否正确"
            rename=false
            repoExist=1
        fi
    done <$temp

    if [ $repoExist -eq 0 ];then
        echo "$addRepoName Repo不存在"
        pod repo add $addRepoName $addRepoURL
        echo "$addRepoName Repo已添加成功"
    fi
}

###################### 2、更新 ######################
function gitPull()
{
    handleProject
    cd $podfilePath
    PrintCurrentRootPath
    git pull
    echo "\033[0;32;1m$yourSelectProject 更新完成 \033[0m"
    echo $XES_TAIL_SEPARATE
    cd $RootPath
}

###################### 3、提交 ######################
function gitPush()
{
    handleProject
    if [ -z $currentProject ];then
        return
    fi
    pro=$currentProject

    echo "请输入commit 信息"

    read commitMsg

    echo "是否要push至git仓库?(Y/N)"

    read needPush

    if [ "$pro" == "$ProjectName_All" ];then
        for moduleName in ${ModuleArr_All[@]}; do
            gitPushSingle $moduleName "$commitMsg" "$needPush"
        done
    else
        gitPushSingle $currentProject "$commitMsg" "$needPush"
    fi
}

# 提交代码
function gitPushSingle()
{
    moduleName=$1
    commitMsg=$2
    needPush=$3
    DIR=`getCodePath $moduleName`
    cd $DIR
    echo `pwd`
    echo "***$moduleName 开始提交"
    if [ ! -z "$commitMsg" ];then
        git add .
        git commit -m "$commitMsg"
        echo "***$moduleName commit add done"
    fi

    if [ "$needPush" == "Y" ];then
        git push
        echo "$moduleName 提交完成"
    fi
    echo $XES_TAIL_SEPARATE
    cd $RootPath
}

###################### 5、打开工程 ######################
function openPath()
{
    handleProject
    currentProjectPath=$podfilePath/*.xcworkspace
    echo "\033[0;32;1m当前打开的工程路径为：$currentProjectPath \033[0m"
    open $podfilePath/*.xcworkspace
}

###################### 6、打开文件夹 ######################
function openFile()
{
    getFileArray
    fileArrayCount=${#FileArray[@]}
    for((i=1;i<=$fileArrayCount;i++));
    do
        echo $i. ${FileArray[$i -1 ]}
    done

    echo $Handle_Back
    echo $SEPARATE_LINE
    PleaseInputYourSelect

    read fileNum
    echo $SEPARATE_LINE

    if [[ $fileNum -eq 0 ]];then
        echo "$SEPARATE_LINE  返回上一级 $SEPARATE_LINE"
        break
    elif  (( "$fileNum" <= "$fileArrayCount" ));then
        podHandle=${FileArray[$fileNum - 1]}
        echo "$SEPARATE_LINE  执行$podHandle $SEPARATE_LINE"

        if [[ $podHandle == $File_Master ]];then #打开主目录
            cd MasterCatalogue
            open .
        elif [[ $podHandle == $File_Shell ]];then #打开脚本文件夹
            cd $RootPath
            open .
        elif [[ $podHandle == $File_CocoaPods ]];then #打开.cocoapods
            CocoaPodsFilePath="$MasterCatalogue/.cocoapods/repos"
            cd $CocoaPodsFilePath
            open .
        elif [[ $podHandle == $File_bash_profile ]];then #打开.bash_profile
            cd MasterCatalogue
            touch .bash_profile
            vim .bash_profile
        elif [[ $podHandle == $File_gitconfig ]];then #打开.gitconfig
            cd MasterCatalogue
            touch .gitconfig
            vim .gitconfig
        else
            echo "!!!输入错误，请重新输入!!!"
            echo "!!!输入错误，请重新输入!!!"
        fi
        cd $RootPath
        echo "$SEPARATE_LINE  执行$podHandle 完成 $SEPARATE_LINE"
    else
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
    fi
}

###################### 8、Clone代码 ######################
# Clone代码
Clone_ZiroomProject="Clone自如项目"
Clone_Other="Clone其他"

function getCloneArray()
{
    CloneArray=(
        $Clone_ZiroomProject
        $Clone_Other
    )
}

Clone_Master_Path="Clone到主目录下"
Clone_Desktop_Path="Clone到桌面"
function getClonePathArray()
{
    ClonePathArray=(
        $Clone_Master_Path
        $Clone_Desktop_Path
    )
}

function clone()
{
    getCloneArray
    cloneArrayCount=${#CloneArray[@]}
    for((i=1;i<=$cloneArrayCount;i++));
    do
        echo $i. ${CloneArray[$i -1]}
    done
    
    echo $Handle_Back
    echo $SEPARATE_LINE
    PleaseInputYourSelect
    
    read cloneNum
    echo $SEPARATE_LINE
    
    if [[ $cloneNum -eq 0 ]];then
        echo "$SEPARATE_LINE  返回上一级 $SEPARATE_LINE"
#        break
    elif  (( "$cloneNum" <= "$cloneArrayCount" ));then
        podHandle=${CloneArray[$cloneNum - 1]}
        echo "$SEPARATE_LINE  执行$podHandle $SEPARATE_LINE"

        if [[ $podHandle == $Clone_ZiroomProject ]];then #Clone自如项目
            echo "Clone自如项目"
        elif [[ $podHandle == $Clone_Other ]];then #Clone其他
            cloneOther
        else
            remindError
        fi
        cd $RootPath
        echo "$SEPARATE_LINE  执行$podHandle 完成 $SEPARATE_LINE"
    else
        remindError
        remindError
    fi
}

function cloneOther()
{
    getClonePathArray
    clonePathCount=${#ClonePathArray[@]}
    for((i=1;i<=$clonePathCount;i++));
    do
        echo $i. ${ClonePathArray[$i -1]}
    done
    
    echo $Handle_Back
    echo $SEPARATE_LINE
    PleaseInputYourSelect
    
    read pathNum
    echo $SEPARATE_LINE
    
    if [[ $pathNum -eq 0 ]];then
        echo "$SEPARATE_LINE  返回上一级 $SEPARATE_LINE"
#        break
    elif  (( "$pathNum" <= "$clonePathCount" ));then
        podHandle=${ClonePathArray[$pathNum - 1]}
        echo "$SEPARATE_LINE  执行$podHandle $SEPARATE_LINE"

        if [[ $podHandle == $Clone_Master_Path ]];then #Clone到主目录下
            cd $MasterCatalogue
            cloneUrlSelect
        elif [[ $podHandle == $Clone_Desktop_Path ]];then #Clone到桌面
            DesktopPath="$MasterCatalogue/Desktop"
            cd $DesktopPath
            cloneUrlSelect
        else
            remindError
        fi
        cd $RootPath
        echo "$SEPARATE_LINE  执行$podHandle 完成 $SEPARATE_LINE"
    else
        remindError
        remindError
    fi
}

function cloneUrlSelect()
{
    echo $Handle_Back
    echo $SEPARATE_LINE
    PleaseInputAddress
    
    read address
    echo $SEPARATE_LINE
    
    if [ $address -eq 0 ];then
        echo "$SEPARATE_LINE  返回上一级 $SEPARATE_LINE"
        break
    elif  [ ! -z $address ];then
        git clone $address
                
        cd $RootPath
        echo "\033[0;32;1m$SEPARATE_LINE 执行Clone $address 完成 $SEPARATE_LINE \033[0m"
    else
        remindError
        remindError
    fi
}

###################### HOME ######################
function homeHandle()
{
    echo $SEPARATE_LINE
    echo "◥███◤ 请开始操作吧 ∝∝∝╬▅▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▅▆▇◤"
    getHandleArr
    handleCount=${#HandleArr[@]}
    for((i=1;i<=$handleCount;i++));
    do
        echo $i. ${HandleArr[$i -1 ]}
    done

    echo $Handle_Exit
    echo $Version_Code
    PrintCurrentRootPath

    echo $SEPARATE_LINE
    PleaseInputYourSelect

    read number
    echo $SEPARATE_LINE

    if [[ $number -eq 0 ]];then
        echo "$SEPARATE_LINE  退出脚本 $SEPARATE_LINE"

        exit
    elif  (( "$number" <= "$handleCount" ));then
        handle=${HandleArr[$number - 1]}
        echo "$SEPARATE_LINE  执行$handle $SEPARATE_LINE"

        if [[ $handle == $Handle_PodHandle ]]; then
            while :
            do
                ZiRoomPodHandle
            done
             echo "1"
        elif [[ $handle == $Handle_Status ]]; then
#            gitStatus
             echo "2"
        elif [[ $handle == $Handle_Pull ]]; then # 更新
             gitPull
        elif [[ $handle == $Handle_Push ]]; then
#            gitPush
             echo "4"
        elif [[ $handle == $Handle_Branch ]]; then
             echo "5"
        elif [[ $handle == $Handle_OpenPath ]]; then
            while :
            do
                openPath
            done
        elif [[ $handle == $Handle_OpenFile ]]; then
            openFile
        elif [[ $handle == $Handle_image_manager2 ]]; then
             handleProject
             cd $podfilePath
             PrintCurrentRootPath
             /usr/local/ziroom/image_manager2/image_manager
#             image_manager2
        elif [[ $handle == $Handle_Clone ]]; then
            clone
        else
            echo "!!!输入错误，请重新输入!!!"
            echo "!!!输入错误，请重新输入!!!"
        fi
        cd $RootPath

        echo "$SEPARATE_LINE  执行$handle 完成 $SEPARATE_LINE"

    else
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
        echo "!!!输入错误，请重新输入!!!"
    fi
}

#############主函数################
Version_Code="Version:1.0.0"
function main()
{
    #主函数
    while :
    do
        homeHandle
        cd $RootPath
    done
}

main
