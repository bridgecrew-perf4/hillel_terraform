### Написать Terraform module, который определяет EC2 instance и несколько сопутствующих ему ресурсов.

Модуль должен принимать несколько входящих параметров (но у них должны быть и значения по умолчанию):

- AWS Instance type
- Public Key
- True/False для создания elastic IP
- Размер в GB для дополнительного volume, который подключается к инстансу

У вашего модуля должно быть 2 output:

- instance ID
- Внешний IP адрес (либо Elastic IP, либо public IP)

Формат сдачи: репозиторий на GitHub; Там должен быть и root module, который вызывает (использует) ваш модуль. Root module должен использовать outputs вашего модуля в собственных outputs. Иными словами, вам нужно продемонстрировать работу вашего модуля таким образом.
Избегайте hardcoding.


##### Доп. инфо:

Resource: aws_instance
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
AMI — произвольный, какой вам нравится
Тип инстанса — произвольный, но я рекомендую t2.micro

Resource: awe_security_group
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
Resource: aws_security_group_rule
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
Набор правил — произвольный, но хотя бы одно правило для входящего трафика должно быть

Resource: aws_key_pair
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
Как и в предыдущей домашней работе: значение по умолчанию плюс возможность задать через переменную

Resource: aws_eip
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
Аналогично предыдущему занятию: возможность определять его создание через логическую (bool) переменную

Resource: aws_ebs_volume
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
Resource: aws_volume_attachment
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment
Дополнительный EBS volume, тип volume — gp2, размер по-умолчанию 8ГБ.
Не определяйте для него provisioned IOPS.
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-volume.html 
