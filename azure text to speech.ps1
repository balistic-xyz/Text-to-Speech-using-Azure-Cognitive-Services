Remove-Variable * -ErrorAction SilentlyContinue

# defining variables Subscription key, Azure region, Resource Group, Output format
    $SubsciptionKey = ''
    $AzureRegion = ''
    $ResourceGroup = ''
    $OutputFormat = ''
# end defining variables

# fetching OAuthToken
     $FetchTokenHeader = @{
      'Content-type'='application/x-www-form-urlencoded';
      'Content-Length'= '0';
      'Ocp-Apim-Subscription-Key' = $SubsciptionKey
    }

    $TokenUrl = 'https://'+$AzureRegion+'.api.cognitive.microsoft.com/sts/v1.0/issuetoken'
    $OAuthToken = Invoke-RestMethod -Method POST -Uri $TokenUrl -Headers $FetchTokenHeader
# end fetching OAuthToken

# start text-to-speech
    $SpeechUrl = 'https://'+$AzureRegion+'.tts.speech.microsoft.com/cognitiveservices/v1'
    $headers = @{
        'Content-Type' = 'application/ssml+xml'
        'X-Microsoft-OutputFormat' = $OutputFormat
        'Authorization' = 'Bearer '+ $OAuthToken
        'User-Agent' = $ResourceGroup
    }
    $body = "<speak version='1.0' xml:lang='en-US'>
    <voice xml:lang='en-US' xml:gender='Female' name='en-US-JennyNeural'>
    text to be translated
    </voice>
    </speak>"
    Invoke-RestMethod -Method POST -Uri $SpeechUrl -Headers $headers -Body $body -OutFile output.mp3
# end start-to-speech