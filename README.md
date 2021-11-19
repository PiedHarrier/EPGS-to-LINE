# EPGS-to-LINE

## Setup
run.shを開いてLINE トークンを書き込みEpgstation のconfigへコピーしchmod +x

config.ymlに下記コマンドを追加
```
reserveNewAddtionCommand: '/bin/sh %ROOT%/config/run.sh reserve'
reserveUpdateCommand: '/bin/sh %ROOT%/config/run.sh update'
reservedeletedCommand: '/bin/sh %ROOT%/config/run.sh delete'
recordingPreStartCommand: '/bin/sh %ROOT%/config/run.sh prestart'
recordingPrepRecFailedCommand: '/bin/sh %ROOT%/config/run.sh prepfailed'
recordingStartCommand: '/bin/sh %ROOT%/config/run.sh start'
recordingFinishCommand: '/bin/sh %ROOT%/config/run.sh end'
recordingFailedCommand: '/bin/sh %ROOT%/config/run.sh recfailed'
```

## License
This repository is provided under the MIT License.
