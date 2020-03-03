#!/bin/bash

# 環境変数

# リポジトリのデータセット
REPOSITORY_LIST='./sample_dataset.csv'
# 作業ディレクトリ
WORKING_DIR='/home/take/develop/hub-projects-collection-script'


cd $WORKING_DIR
i=1
while read row; do
  USERNAME=`echo ${row} | cut -d , -f 12`
  REPO_NAME=`echo ${row} | cut -d , -f 4`
  REPO_URI="https://github.com/${USERNAME}/${REPO_NAME}"
 
  echo $REPO_URI 

  git clone $REPO_URI
 
  if [ -d $REPO_URI ];then
    echo "Repository exists."

    cd $REPO_NAME
    git checkout master
    git pull

    FILE_LIST=("README.md" "readme.md" "README.MD" "readme.MD" "readme.rst" "README.RST" "README.rst")

    j=0
    for FILE in ${FILE_LIST[@]}; do
      if [ -e $FILE ]; then
        echo $FILE
        echo "File exists."
        cp $FILE "../tmp/${i}_${REPO_NAME}_${FILE}"
      fi
      let j++
    done
    rm -r "./${REPO_NAME}"
  fi

  cd $WORKING_DIR
  i=`expr $i + 1`
done < $REPOSITORY_LIST