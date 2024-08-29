#!/bin/bash

# File JSON di configurazione
file="workspace.conf"

# Nome della cartella che contiene il lab
nome_lab=$(./jq -r ".nome_lab" $file)

# Creazione cartella lab
mkdir -p $nome_lab
touch "$nome_lab/lab.conf"

# Nome cartella da cui prendere i template delle configurzioni
cartella_configurazioni=$(./jq -r ".cartella_configurazioni" $file)

# Numero di macchine da configurare
n_macchine=$(./jq ".macchine | length" $file)
n_macchine=$(( n_macchine - 1 ))

# Per ogni macchina
for i in $(seq 0 $n_macchine) ; do
	
	# Nome della macchina
	nome_macchina=$(./jq -r ".macchine[$i].nome_macchina" $file)
	
	# Creazione file .startup
	file_startup="$nome_lab/$nome_macchina.startup"
	touch $file_startup
	
	# Creazione della directory nome_macchina/etc/frr 
	dir="$nome_lab/$nome_macchina/etc/frr"
	mkdir -p "$nome_lab/$nome_macchina/etc/frr"
	
	# I template dei file di configurazione vengono copiati nella directory /etc/frr
	cp "$cartella_configurazioni/vtysh.conf" "$nome_lab/$nome_macchina/etc/frr"
	cp "$cartella_configurazioni/frr.conf" "$nome_lab/$nome_macchina/etc/frr"
	cp "$cartella_configurazioni/daemons" "$nome_lab/$nome_macchina/etc/frr"

	# Configurazione file /etc/frr/vtysh.conf
	sed -i '' "s/nome_host/$nome_macchina-frr/g" "$nome_lab/$nome_macchina/etc/frr/vtysh.conf"
	
	# Numero di interfacce da configurare
	numero_interfacce=$(./jq ".macchine[$i].numero_interfacce" $file)
	numero_interfacce=$(( numero_interfacce - 1 ))
	
	# Configurazione lab.conf
	for k in $(seq 0 $numero_interfacce) ; do
		
		dominio=$(./jq -r ".macchine[$i].interfacce[$k].dominio" $file)
		comando="$nome_macchina[$k]="'"'"$dominio"'"'
		echo $comando >> "$nome_lab/lab.conf"
	
	done
	echo "" >> "$nome_lab/lab.conf"
	
	# Configurazione interfacce in .startup
	for k in $(seq 0 $numero_interfacce) ; do
		
		ip=$(./jq -r ".macchine[$i].interfacce[$k].ip" $file)
		maschera=$(./jq -r ".macchine[$i].interfacce[$k].maschera" $file)
		comando="/sbin/ifconfig en"$k" $ip netmask $maschera up"
		echo $comando >> $file_startup
	
	done
	echo "/etc/init.d/frr start" >> $file_startup
	
	# Configurazione file /etc/frr/daemons
	m=$(./jq ".macchine[$i].protocolli | length" $file)
	m=$(( m - 1 ))
	for j in $(seq 0 $m) ; do
	
		protocollo=$(./jq -r ".macchine[$i].protocolli[$j]" $file)
		if [ "$protocollo" = "BGP" ]; then
			
			sed -i '' "s/bgpd=no/bgpd=yes/g" "$nome_lab/$nome_macchina/etc/frr/daemons"
			
		elif [ "$protocollo" = "OSPF" ]; then
		
			sed -i '' "s/ospfd=no/ospfd=yes/g" "$nome_lab/$nome_macchina/etc/frr/daemons"
		
		elif [ "$protocollo" = "RIP" ]; then
	
			sed -i '' "s/ripd=no/ripd=yes/g" "$nome_lab/$nome_macchina/etc/frr/daemons"
		
		fi
		
	done

done