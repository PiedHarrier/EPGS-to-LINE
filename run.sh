#!/bin/sh

# 環境変数 LINE_TOKEN に取得したトークンを指定してください。
LINE_TOKEN="ここにLINE_TOKEN貼り付け"

if [ $# = 1 ]; then

    # チャンネル名, チャンネルタイプ, 番組名, 番組概要の読み込み
    if [ -z "$CHANNELTYPE" ]; then
        CHANNELTYPE="チャンネルタイプ未設定"
    else
        :
    fi
    if [ -z "$CHANNELNAME" ]; then
        CHANNELNAME="放送局名なし"
    else
        :
    fi
    if [ -z "$NAME" ]; then
        title="タイトル未設定"
    else
        title=$NAME
    fi
    if [ -z "$DESCRIPTION" ]; then
        description="番組概要が指定されていません。"
    else
        description=$DESCRIPTION
    fi
    
    # 引数をコピー (コマンドとして認識されるのを防ぐため)
    ret=$1

   # 予約関係: 追加, 削除, 更新, 録画準備
    if [ $ret = "reserve" ]; then
        content="✅ **予約追加**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`"
    elif [ $ret = "delete" ]; then
        content="💨 **予約削除**\n番組名: ${title}@ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`"
    elif [ $ret = "update" ]; then
        content="🔁 **予約更新**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`"
    elif [ $ret = "prestart" ]; then
        content="🔷 **録画準備開始**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`"
    elif [ $ret = "prepfailed" ]; then
        content="💥 **録画準備失敗**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`"
    elif [ $ret = "start" ]; then
        content="⏺ **録画開始**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`"
    elif [ $ret = "end" ]; then
        # エラー, ドロップ, スクランブルカウントを読み込み
        if [ -z "$ERROR_CNT" ]; then
            ERROR_CNT="N/A"
        else
            : # 何もしない
        fi
        if [ -z "$DROP_CNT" ]; then
            DROP_CNT="N/A"
        else
            : # 何もしない
        fi
        if [ -z "$SCRAMBLING_CNT" ]; then
            SCRAMBLING_CNT="N/A"
        else
            : # 何もしない
        fi
        content="⏹ **録画終了**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`\nエラー: ${ERROR_CNT}, ドロップ: ${DROP_CNT}, スクランブル: ${SCRAMBLING_CNT}"
    elif [ $ret = "recfailed" ]; then
        # エラー, ドロップ, スクランブルカウントを読み込み
        if [ -z "$ERROR_CNT" ]; then
            ERROR_CNT="N/A"
        else
            : # 何もしない
        fi
        if [ -z "$DROP_CNT" ]; then
            DROP_CNT="N/A"
        else
            : # 何もしない
        fi
        if [ -z "$SCRAMBLING_CNT" ]; then
            SCRAMBLING_CNT="N/A"
        else
            : # 何もしない
        fi
        content="❌ **録画失敗**\n番組名: ${title} @ ${CHANNELTYPE} ${CHANNELNAME}\n番組概要:\n\`\`\`\n${description}\n\`\`\`\nエラー: ${ERROR_CNT}, ドロップ: ${DROP_CNT}, スクランブル: ${SCRAMBLING_CNT}"
    else
        echo "引数が不正です。"
        exit 1
    fi
        
    
    curl -X POST -H "Authorization: Bearer ${LINE_TOKEN}" -F "message=${content}" https://notify-api.line.me/api/notify
    
else
    echo "引数を指定してください。"
fi
