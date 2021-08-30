# Домашняя работа №7
### Часть 1
Для работы использовал Hyper-V установлена CentOs7 с lvm и uefi
Поочередно попробовал все предложенные способы для входа в систмему без пароля
В конец строки начинающейся с linuxefi добвалял init=/bin/sh, rd.break, rw init=/sysroot/bin/sh
после чего комбинация CTRL+X
Во всех случаях cкрипты работали , для теста сделал в скрипт test.sh в /test 
Скрины ниже

![Иллюстрация к проекту](https://github.com/asm1213/DZ_7/blob/main/pics/1.jpg)
![Иллюстрация к проекту](https://github.com/asm1213/DZ_7/blob/main/pics/2.jpg)
![Иллюстрация к проекту](https://github.com/asm1213/DZ_7/blob/main/pics/3.jpg)
![Иллюстрация к проекту](https://github.com/asm1213/DZ_7/blob/main/pics/4.jpg)
### Часть 2
Переименовал volumegroup и отредактировал /etc/fstab, /etc/default/grub и в моем случае /boot/efi/EFI/centos/grub.cfg
 
[лог файл](https://github.com/asm1213/DZ_7/blob/main/log_2.log)

### Часть3
Лог и иллюстрация
[лог файл](https://github.com/asm1213/DZ_7/blob/main/log_3.log)
![Иллюстрация к проекту](https://github.com/asm1213/DZ_7/blob/main/pics/5.jpg)
