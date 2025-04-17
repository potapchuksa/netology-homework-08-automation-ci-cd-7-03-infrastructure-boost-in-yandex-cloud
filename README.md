# Домашнее задание к занятию «Подъём инфраструктуры в Yandex Cloud». Потапчук Сергей.

### Оформление домашнего задания

1. Домашнее задание выполните в [Google Docs](https://docs.google.com/) и отправьте на проверку ссылку на ваш документ в личном кабинете.  
1. В названии файла укажите номер лекции и фамилию студента. Пример названия: 7.3. Подъём инфраструктуры в Yandex Cloud — Александр Александров.
1. Перед отправкой проверьте, что доступ для просмотра открыт всем, у кого есть ссылка. Если нужно прикрепить дополнительные ссылки, добавьте их в свой Google Docs.

Вы можете прислать решение в виде ссылки на ваш репозийторий в GitHub, для этого воспользуйтесь [шаблоном для домашнего задания](https://github.com/netology-code/sys-pattern-homework).

 ---
## Важно

Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).

---

### Задание 1 

Повторить демонстрацию лекции(развернуть vpc, 2 веб сервера, бастион сервер)

### Решение

Установил CLI для Яндекс облака

![](img/img-01-00.png)

и подготовил облако с его помощью к работе с Terraform. Создал новую папку,

![](img/img-01-01.png)

![](img/img-01-02.png)

создал сервисный аккаунт terraform,

![](img/img-01-03.png)

добавил ему роль editor в катологе netology-homework,

![](img/img-01-04.png)

создал авторизованный ключ и он скачался на локальную машину в домашний каталог.

![](img/img-01-05.png)

![](img/img-01-06.png)

![](img/img-01-07.png)

![](img/img-01-08.png)

![](img/img-01-09.png)

Создал файл providers.tf,

![](img/img-01-10.png)

![](img/img-01-11.png)

файл network.tf,

![](img/img-01-12.png)

![](img/img-01-13.png)

![](img/img-01-14.png)

![](img/img-01-15.png)

файл variables.tf,

![](img/img-01-18.png)

![](img/img-01-19.png)

файл vms.tf

![](img/img-01-20.png)

![](img/img-01-21.png)

![](img/img-01-22.png)

![](img/img-01-23.png)

![](img/img-01-24.png)

![](img/img-01-25.png)

файл cloud-config.yml для создания пользователя user, добавления его в группу sudo, повышения его привелегий без запроса пароля и передачи на ВМ публичного ключа.

![](img/img-01-26.png)

![](img/img-01-27.png)

Инициируем terraform, успешно.

![](img/img-01-28.png)

![](img/img-01-29.png)

Применяем, при запросе подтверждаем.

![](img/img-01-30-1.png)

Проверяем результат через web-интерфейс Yandex cloud.

![](img/img-01-30.png)

![](img/img-01-31.png)

Создаем конфигурационный файл Ansible.

![](img/img-01-32.png)

![](img/img-01-33.png)

Создаем плейбук.

![](img/img-01-34.png)

![](img/img-01-35.png)

Запускаем проверку созданных ВМ.

![](img/img-01-36.png)

Файлы Terraform находятся [здесь](my-terraform/), Ansible - [здесь](my-ansible/)

---

### Задание 2 

С помощью ansible подключиться к web-a и web-b , установить на них nginx.(написать нужный ansible playbook)


Провести тестирование и приложить скриншоты развернутых в облаке ВМ, успешно отработавшего ansible playbook. 

### Решение

Создал [плейбук](my-ansible/installing-nginx.yml) installing-nginx.yml

![](img/img-02-01.png)

![](img/img-02-02.png)

Добавил в vms.tf блок, который создаёт файл конфигурации для ssh

![](img/img-02-03.png)

![](img/img-02-04.png)

После создания скопировал его в папку ~/.ssh/

![](img/img-02-05.png)

Изменил файл ansible.cfg

![](img/img-02-06.png)

![](img/img-02-07.png)

Запустил плейбук

![](img/img-02-08.png)

Файлы Terraform находятся [здесь](my-terraform/), Ansible - [здесь](my-ansible/)

---

## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите глубже и/или шире разобраться в материале.

--- 

### Задание 3*

**Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.**

1. Добавить еще одну виртуальную машину. 
2. Установить на нее любую базу данных. 
3. Выполнить проверку состояния запущенных служб через Ansible.

### Решение

В файле network.tf

![](img/img-03-01.png)

добавил еще одну подсеть

![](img/img-03-02.png)

и группу безопасности для СУБД

![](img/img-03-03.png)

в файле vms.tf

![](img/img-03-04.png)

добавил еще одну машину

![](img/img-03-05.png)

и обновил вывод в файл hosts.ini

![](img/img-03-06.png)

Применил, посмотрел через web-интерфейс

![](img/img-03-07.png)

![](img/img-03-08.png)

Создал плейбук db-inst.yml (ни ansible.builtin.systemd, ни ansible.builtin.command, ни ansible.builtin.shell не работают, даже просто command выдал пустой список, остальные команды просто вызывали ошибку, надо будет обновить Ansible, и попробовать сделать по-нормальному, я понимаю, что shell, это не та команда, которую следует использовать, но как есть)

![](img/img-03-09.png)

![](img/img-03-10.png)

![](img/img-03-11.png)

Файлы Terraform находятся [здесь](my-terraform/), Ansible - [здесь](my-ansible/)

--- 

### Задание 4*
Изучите [инструкцию](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart) yandex для terraform.
Добейтесь работы паплайна с безопасной передачей токена от облака в terraform через переменные окружения. Для этого:

1. Настройте профиль для yc tools по инструкции.
2. Удалите из кода строчку "token = var.yandex_cloud_token". Terraform будет считывать значение ENV переменной YC_TOKEN.
3. Выполните команду export YC_TOKEN=$(yc iam create-token) и в том же shell запустите terraform.
4. Для того чтобы вам не нужно было каждый раз выполнять export - добавьте данную команду в самый конец файла ~/.bashrc

### Решение

---

Дополнительные материалы: 

1. [Nginx. Руководство для начинающих](https://nginx.org/ru/docs/beginners_guide.html). 
2. [Руководство по Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/doc). 
3. [Ansible User Guide](https://docs.ansible.com/ansible/latest/user_guide/index.html).
1. [Terraform Documentation](https://www.terraform.io/docs/index.html).
