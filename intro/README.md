###Задача-1
Заменить в определении instance_type строку с названием типа инстанса на переменную со значением по-умолчанию.

Для доп инфо смотри комментарий в файле `instance.tf` — там есть ссылки на нужную документацию aws provider

###Задача-2
Добавить определение ssh ключа (instance key pair), публичную часть (public key) которого можно передать в код в виде переменной.

Что такое key pair — https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

Для доп инфо смотри комментарий в файле `instance.tf` — там есть ссылки на нужную документацию aws provider

###Задача-3
Добавить использование (указание) вашего key pair в описании ресурса aws_instance

Для доп инфо смотри комментарий в файле `instance.tf` — там есть ссылки на нужную документацию aws provider

###Задача-4
Добавить в output вывод информации об elastic IP, если он создан и назначен инстансу.

Что такое elastic IP — https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html

Для доп инфо смотри комментарий в файле intro/instance.tf — там есть ссылки на нужную документацию aws provider 
