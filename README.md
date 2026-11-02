# WiiMotion Mobile

App Android que transforma o celular em um Wii Remote virtual para o **Dolphin Emulator**, transmitindo botões e sensores de movimento pela rede local usando o protocolo DSU/Cemuhook.

## O que vem no projeto

- App Android nativo em Kotlin, em modo paisagem.
- Servidor DSU integrado ao celular, porta UDP `26760` — não precisa instalar um servidor no PC.
- Acelerômetro e giroscópio do telefone.
- Botões na tela: direcional, A, B, 1, 2, +, − e Home.
- Botões C/Z e analógico virtual para jogos com Nunchuk.
- Área de toque para controlar o ponteiro IR do Wii Remote.
- Calibração do giroscópio e indicação de estado do servidor.
- Dois perfis do Dolphin: Wii Remote padrão e Wii Remote + Nunchuk.

> O telefone e o computador precisam estar conectados à mesma rede Wi-Fi. O aplicativo deve permanecer aberto durante a partida. O ponteiro é controlado pela área de toque do app; não é uma barra sensora infravermelha física.

## Gerar o APK no Windows

1. Instale o **Android Studio** com o Android SDK e o JDK 17.
2. Extraia esta pasta e abra `WiiMotionMobile` no Android Studio.
3. Aguarde a sincronização do Gradle e a instalação do Android SDK Platform 35, caso o Android Studio solicite.
4. Selecione **Build → Build Bundle(s) / APK(s) → Build APK(s)**.
5. O APK de teste será criado em:

   `app/build/outputs/apk/debug/app-debug.apk`

6. Copie o APK para o celular e instale-o. No Android, pode ser necessário autorizar a instalação de aplicativos dessa fonte.

Também existe um workflow opcional em `.github/workflows/android.yml` para compilar o APK no GitHub Actions depois que o projeto for colocado em um repositório.

## Configurar o Dolphin

1. Conecte o PC e o celular à mesma rede Wi-Fi.
2. Abra o WiiMotion Mobile e toque em **CONECTAR AO DOLPHIN**.
3. Anote o IP mostrado no topo do aplicativo.
4. No Dolphin, abra **Controllers → Alternate Input Sources** e marque **Enable**.
5. Clique em **Add** e informe o IP do celular, porta `26760` e descrição `Controle Celular`.
6. Na área **Wii Remotes**, escolha **Emulated Wii Remote** para `Wii Remote 1` e clique em **Configure**.
7. Na lista de dispositivos, selecione `DSUClient/0/Controle Celular`.
8. Copie o perfil desejado para a pasta de perfis do Dolphin executando `instalar-perfis-dolphin.bat` neste projeto. O script instala em:

   `%USERPROFILE%\Documents\Dolphin Emulator\Config\Profiles\Wiimote\`

9. Em **Profile**, selecione `WiiMote-Celular` e clique em **Load**. Para jogos que usam Nunchuk, carregue `WiiMote-Celular-Nunchuk`.
10. No perfil padrão, deixe **Extension = None**. No perfil Nunchuk, a extensão Nunchuk já está configurada.
11. Mantenha o app aberto, volte ao jogo e teste os botões e o movimento.

Os nomes dos menus podem variar um pouco conforme a versão do Dolphin. A documentação oficial explica a configuração de controles em **Options/Controllers** e a opção **Alternate Input Sources**.

## Calibrar e usar

- Segure o telefone na posição que deseja usar como centro e toque em **CALIBRAR MOVIMENTO**.
- Use o direcional e os botões na tela como os botões do Wii Remote.
- No perfil Nunchuk, o círculo **NUNCHUK** controla o analógico; C e Z são botões separados.
- O círculo **PONTEIRO IR** controla a direção do ponteiro em jogos que usam apontar para a tela.
- Caso o giroscópio não apareça como disponível, o aparelho pode não ter esse sensor. O acelerômetro sozinho não oferece o mesmo controle completo.

## Solução de problemas

**O Dolphin não mostra `DSUClient/0/Controle Celular`:** confirme que o servidor está ativo no app, que o IP foi digitado corretamente e que os dois dispositivos estão na mesma rede. Feche e reabra a janela de configuração do controle depois de iniciar o servidor.

**O app mostra “Servidor ativo”, mas não conecta:** confirme se a rede Wi-Fi permite comunicação entre dispositivos (algumas redes de convidados isolam os aparelhos) e se nenhum outro app está usando a porta UDP `26760` do telefone.

**Os movimentos estão invertidos:** abra a configuração do Wii Remote no Dolphin e ajuste a opção **Invert** dos eixos de acelerômetro/giroscópio. A orientação dos sensores varia entre modelos de celular.

**O ponteiro não aparece:** verifique se o jogo usa o ponteiro IR e se o perfil carregado contém as linhas `IR/Up`, `IR/Down`, `IR/Left` e `IR/Right`. Use a área **PONTEIRO IR** no telefone.

## Sobre o protocolo

O app implementa o protocolo UDP DSU/Cemuhook (cabeçalho `DSUS`, versão 1001, CRC32, consulta de versão, consulta de slots e fluxo de dados do controle). A estrutura dos dados segue a referência pública do protocolo.

- Dolphin — guia de configuração de controles: https://dolphin-emu.org/docs/guides/configuring-controllers/
- Referência DSU/Cemuhook: https://v1993.github.io/cemuhook-protocol/

## Observação sobre esta entrega

Este pacote contém o **projeto Android completo e os perfis do Dolphin**. O ambiente em que os arquivos foram preparados não possui Android SDK/Gradle configurado, então não foi possível compilar nem testar um APK neste computador. O APK é gerado pelo Android Studio seguindo os passos acima. O código-fonte deve ser compilado e testado no aparelho e na versão do Dolphin que você utiliza antes de uma sessão longa de jogo.

## Compilar o APK no Codemagic (sem instalar ferramentas no PC)

Este projeto inclui `codemagic.yaml` e `README-CODEMAGIC.txt`. O workflow compila um APK Debug usando Java 17, Android SDK 35 e Gradle 8.9. Ele instala o Gradle no próprio ambiente de build, então não depende de `gradlew.bat` instalado no seu Windows.

**Atenção:** o Codemagic exige que o código esteja em um repositório Git conectado (por exemplo, GitHub); não basta enviar o ZIP diretamente. Extraia o pacote e envie o conteúdo da pasta `WiiMotionMobile` para a raiz do repositório, mantendo `codemagic.yaml` nessa raiz. Depois conecte o repositório no Codemagic, selecione o workflow `WiiMotion Mobile - APK Android (Debug)` e inicie o build.

Quando o build terminar, baixe `app-debug.apk` na seção **Artifacts**. É um APK Debug assinado para instalação e teste manual, não um APK Release preparado para publicação na Play Store. Consulte `README-CODEMAGIC.txt` para o passo a passo.
