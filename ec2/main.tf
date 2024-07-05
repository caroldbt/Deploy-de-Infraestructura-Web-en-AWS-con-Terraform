resource "aws_instance" "example" {
  subnet_id              = var.subnet_id
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "example-instance"
  }

  iam_instance_profile = "LabInstanceProfile"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y && sudo yum install httpd -y && sudo systemctl start httpd && sudo systemctl enable httpd
    sudo chkconfig httpd on
    cd /var/www/html
    sudo yum install php php-cli php-json php-mbstring -y
    sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    sudo php composer-setup.php
    sudo php -r "unlink('composer-setup.php');"
    sudo php composer.phar require aws/aws-sdk-php
    echo "AddType application/x-httpd-php .php" | sudo tee -a /etc/httpd/conf/httpd.conf
    sudo systemctl restart httpd

    echo "<!DOCTYPE html>
    <html lang='en'>
    <head>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <title>Contact Form</title>s
    </head>
    <body>
        <h1>Contact Form</h1>
        <form action='submit.php' method='POST'>
            <label for='name'>Name:</label><br>
            <input type='text' id='name' name='name' required><br>
            <label for='email'>Email:</label><br>
            <input type='email' id='email' name='email' required><br>
            <label for='message'>Message:</label><br>
            <textarea id='message' name='message' rows='4' required></textarea><br>
            <input type='submit' value='Submit'>
        </form>
    </body>
    </html>
    " | sudo tee index.html > /dev/null

    cat <<EOP > submit.php
    <?php
    require 'vendor/autoload.php';

    use Aws\Sns\SnsClient;
    use Aws\Exception\AwsException;

    if (\$_SERVER["REQUEST_METHOD"] == "POST") {
        \$name = \$_POST["name"];
        \$email = \$_POST["email"];
        \$message = \$_POST["message"];

        \$snsTopicArn = "${var.sns_topic_arn}";

        \$snsClient = new SnsClient([
            'version' => 'latest',
            'region' => 'us-east-1'
        ]);

        \$messageToSend = json_encode([
            'email' => \$email,
            'name' => \$name,
            'message' => \$message
        ]);

        try {
            \$snsClient->publish([
                'TopicArn' => \$snsTopicArn,
                'Message' => \$messageToSend
            ]);

            echo "Message sent successfully.";
        } catch (AwsException \$e) {
            echo "Error sending message: " . \$e->getMessage();
        }
    } else {
        http_response_code(405);
        echo "Method Not Allowed";
    }
    ?>
    EOP
  EOF
}


