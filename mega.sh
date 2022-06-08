#!/bin/bash
#clear

apaga_arquivos()
{

    if [ -f "resultado.dat" ]; 
        then
           rm resultado.dat >> null
        fi

    rm ns*.dat >> null
    rm *.bil
}

mostra_resultado(){
    clear
    cat "$arquivo"
    tela
    echo "Atenção!"
    echo "Os bilhetes gerados podem ser conferidos no arquivo: bilhetes_gerados.txt"
    echo "Bilhete sugerido:"
    echo "     x |número a jogar"
    #tail -n 6 ns5.dat
    head -n 6 ns5.dat

    
}


tela(){
    clear
    echo 
    echo "*************************************************************"
    echo
    figlet simulador
    figlet mega-sena
    echo "    by: Marcelo Fournier - fournier.marcelo@gmail.com"
    echo
    echo "*************************************************************"
    echo
}

inicializa()
{
    clear
    arquivo="resultado.dat"
    apaga_arquivos
    tela
    cat LEIAME.md
    echo "===> Gerar quantos bilhetes da mega-sena?:"
    read bilheteMax

    
    echo "Rodando sorteio mega-sena $bilheteMax vezes"
    echo "Este script irá gerar $bilheteMax bilhetes aleatórios da mega-sena."
    echo "Em seguida, lhe apresentará um bilhete com os números sugeridos."
    echo
    echo "Pressione ENTER para continuar..."
    read tmp

    #echo =================
    for (( bilhete=1; bilhete<=bilheteMax; bilhete++ ))
        do
            #echo "Concurso: " -n "$bilhete "
            echo "=================================" >> bilhetes_gerados.dat
            echo "Bilhete número "$bilhete >> bilhetes_gerados.dat
            echo "---------------------------------" >> bilhetes_gerados.dat
            shuf -i 1-60 -n 6 >> "$bilhete.bil"
            cat  "$bilhete.bil"    >> bilhetes_gerados.dat
            cat  "$bilhete.bil"    >> ns.dat
            echo "$bilhete gerado"

            #echo "=================================" >> resultado.dat
        done

        sort -n ns.dat >> ns2.dat
        cat ns2.dat | uniq >> ns3.dat
        uniq -c ns2.dat > ns4.dat
        sort -r ns4.dat > ns5.dat
        

}

main(){

    inicializa
    #processa
    mostra_resultado
    apaga_arquivos
    echo
    echo "Processamento concluido! Boa sorte!!!"

}

main


