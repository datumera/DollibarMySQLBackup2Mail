!/bin/bash
# Script de backup hecho por dAtUmErA

# Definimos variable timestamp con hora actual
timestamp=`date +%Y%m%d_%H%M%S`

# Mostreo del timestamp
echo "######################################################"
echo "# El backup será generado con el siguiente timestamp #"
echo "# $timestamp                                    # "
echo "######################################################"
echo ""

echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "# El backup fué generado con el siguiente timestamp  #" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "# $timestamp                                    # " >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log

echo "######################################################" > /opt/backups/conf/mailmessage_backup_dolibarr
echo " El backup fué generado con el siguiente timestamp" >> /opt/backups/conf/mailmessage_backup_dolibarr
echo " $timestamp                                     " >> /opt/backups/conf/mailmessage_backup_dolibarr
echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
echo "" >> /opt/backups/conf/mailmessage_backup_dolibarr

# Backup MySQL ONLY for db dolibarr
echo "######################################################"
echo "#     Lanzando backup mysql sobre DB dolibarr        #"
echo "######################################################"

echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "#     Lanzando backup mysql sobre DB dolibarr        #" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log

echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
echo " Lanzando backup mysql sobre DB dolibarr " >> /opt/backups/conf/mailmessage_backup_dolibarr
echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
mysqldump -u root -pXXXXXXX dolibarr > /opt/backups/mysql_data/dolibarr_backup_$timestamp.sql
if [ $? == 0 ]; then
        echo "Backup was successful"
        echo ""
        echo "Backup was successful" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo ""  >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "Backup was successful" >> /opt/backups/conf/mailmessage_backup_dolibarr
        echo "" >> /opt/backups/conf/mailmessage_backup_dolibarr
else
        echo "Backup has failed"
        echo ""
        echo "Backup has failed" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "Backup has failed" >> /opt/backups/conf/mailmessage_backup_dolibarr
        echo "" >> /opt/backups/conf/mailmessage_backup_dolibarr
fi

# Comprimimos la exportacion hecha con mysqldump
echo "######################################################"
echo "#           Comprimiendo fichero .sql                #"
echo "######################################################"

echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "#           Comprimiendo fichero .sql                #" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log

echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
echo " Comprimiendo fichero .sql " >> /opt/backups/conf/mailmessage_backup_dolibarr
echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
gzip -9 -c /opt/backups/mysql_data/dolibarr_backup_$timestamp.sql > /opt/backups/mysql_compressed/dolibarr_compressed_$timestamp.sql.gz
if [ $? == 0 ]; then
        echo "Compression was sucessful"
        echo ""
        echo "Compression was sucessful" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "Compression was sucessful" >> /opt/backups/conf/mailmessage_backup_dolibarr
        echo "" >> /opt/backups/conf/mailmessage_backup_dolibarr
else
        echo "Backup has failed"
        echo ""
        echo "Backup has failed" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "Backup has failed" >> /opt/backups/conf/mailmessage_backup_dolibarr
        echo "" >> /opt/backups/conf/mailmessage_backup_dolibarr
fi

#~Enviamos fichero por e-mail
echo "######################################################"
echo "#            Enviando fichero por e-mail             #"
echo "######################################################"

echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "#            Enviando fichero por e-mail             #" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
echo "######################################################" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log

echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
echo " Enviando fichero por e-mail " >> /opt/backups/conf/mailmessage_backup_dolibarr
echo "######################################################" >> /opt/backups/conf/mailmessage_backup_dolibarr
export EMAIL="Admin <admin@aeipcanaurell.org>" && mutt -s "Dolibarr backup" aeipcanaurell@gmail.com -a /opt/backups/mysql_compressed/dolibarr_compressed_$timestamp.sql.gz < /opt/backups/conf/mailmessage_backup_dolibarr

if [ $? == 0 ]; then
        echo "E-mail was sent correctly"
        echo ""
        echo "E-mail was sent correctly" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
else
        echo "E-mail has failed"
        echo ""
        echo "E-mail has failed" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        echo "" >> /opt/backups/logs/mysql_dolibarr_backup_$timestamp.log
        exit 1
fi

exit 0
