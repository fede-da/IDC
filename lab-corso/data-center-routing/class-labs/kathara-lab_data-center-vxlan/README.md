## VXLAN sulle tof
Stesso file startup, cambia router-id su file bgpd.conf il resto del file è lo stesso

## VXLAN sulle spine
Stesso file startup, cambia numero AS e router-id su file bgpd.conf il resto del file è lo stesso

## VXLAN sulle leaf, configurazione bgpd file
Solitamente cambia solo router-id e numero AS. 

## VXLAN sulle leaf, configurazione startup file
Solitamente nella configurazione di leaf con VXLAN cambia solo indirizzo ip e non la porta. 
Tutte le leaf collegate allo stesso/i server condividono indirizzo loopback come in questo lab

## VXLAN sui server, configurazione startup file
La configurazione è la stessa per tutti i server, la piccola differenza è nella gestione del bridge.
Quando nel file di startup si incontra il commento

**# Attach interfaces to the bridge**

Dobbiamo configurare un'interfaccia per ogni LAN su cui il server si affaccia verso i container nello strato sottostante (in questo lab, parliamo delle LAN con due lettere "AA", "AB"...).
N.B.: Le interfacce "eth0" ed "eth1" solitamente si affacciano verso le leaf, mentre le altre "eth2/3 ecc" danno verso i container.

Quando nel file di startup si incontra il commento

**# Enable bridge vlans**

Bisogna configurare le VLAN in base a quelle che ogni specifico server gestisce.
Ad esempio: il `server_1_1` gestisce VLAN `10` e `20` mentre il `server_1_2` gestisce VLAN `30` e `20` 

## VXLAN sui container
Stesso startup file, cambia solo indirizzo e porta. L'indirizzo è quello definito dalla VLAN di appartenenza, bisogna solo far variare l'utlimo ottetto.
