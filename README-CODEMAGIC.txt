WiiMotion Mobile - Compilar APK no Codemagic
============================================

O projeto já inclui o arquivo codemagic.yaml. Ele configura a compilação de
um APK Android de teste (Debug) usando Java 17, Android SDK 35 e Gradle 8.9.
Não é necessário instalar Android Studio ou Gradle no seu computador.

IMPORTANTE: o Codemagic não compila um ZIP enviado diretamente pela tela.
Ele precisa acessar um repositório Git (por exemplo, GitHub) que contenha os
arquivos do projeto. O codemagic.yaml deve ficar na raiz desse repositório.

PASSO A PASSO
-------------

1. Baixe e extraia WiiMotionMobile-Codemagic.zip.
2. Entre na pasta WiiMotionMobile que foi extraída.
3. Crie um repositório no GitHub, por exemplo WiiMotionMobile.
4. Envie TODOS os arquivos e pastas que estão dentro da pasta WiiMotionMobile
   para a RAIZ do repositório GitHub. Não envie uma pasta WiiMotionMobile
   dentro de outra pasta WiiMotionMobile: codemagic.yaml precisa ficar na raiz.
5. Entre em https://codemagic.io/ e conecte sua conta GitHub.
6. Clique em Add application e escolha o repositório WiiMotionMobile.
7. Selecione a configuração por codemagic.yaml. O nome do workflow é:
   "WiiMotion Mobile - APK Android (Debug)".
8. Clique em Start new build e escolha a branch enviada (normalmente main).
9. Quando a compilação terminar com sucesso, abra Artifacts e baixe o APK.

ARQUIVO GERADO
--------------
app-debug.apk

O APK estará disponível como artefato do build no Codemagic. Ele é um APK
Debug assinado automaticamente com a chave de depuração do Android e pode
ser instalado manualmente no celular para testes. Não é uma versão Release
assinada com uma chave própria para publicação na Play Store.

SE A COMPILAÇÃO FALHAR
----------------------
Abra o build no Codemagic e consulte Logs. O primeiro erro em vermelho é o
mais útil. Guarde ou envie o log para que o problema possa ser corrigido.

Não compartilhe senhas, tokens ou chaves privadas nos logs ou no repositório.
