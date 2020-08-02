#!/bin/bash
#
#       Autor: EDUARDO
#       Criar branch em todos os repositórios

# Lista nome dos repositorios
for REPONAME in $(aws codecommit list-repositories|grep repositoryName|cut -d\" -f4); do

        # Repo da vez
        echo "$REPONAME - Repositorio da vez." >>/tmp/logcreatebranch.log 2>&1


        # Lista commit-id da branch development da repositorio da vez no laco
        for DEVELOPMENTID in $(aws codecommit get-branch --repository-name $REPONAME --branch-name development|grep commitId|cut -d\" -f4 );do

                # Criar branch "test" com commit-id e repo name dos laços.
                aws codecommit create-branch --repository-name $REPONAME --branch-name test --commit-id $DEVELOPMENTID 
                if [ $? -ne 0 ]; then
                        echo "$REPONAME - $DEVELOPMENTID - erro!" >> /tmp/logcreatebranch.log
                else
                        echo "$REPONAME - $DEVELOPMENTID - Sucesso!" >> /tmp/logcreatebranch.log
                fi

        done

done
