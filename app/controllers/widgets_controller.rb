class WidgetsController < ApplicationController

  include ::Plivo



def ivr

    $NO_INPUT_MESSAGE = "Sorry, I didn't catch that. Please hangup and try again later."
    $IVR_MESSAGE1="My name is sanjeev & I wish u good morning. Now enter a digit"
    r = Response.new()

    getdigits_action_url = "https://morning-peak-65848.herokuapp.com/widgets/tre"
    params = {
        'action' => getdigits_action_url,
        'method' => 'POST',
        'timeout' => '7',
        'numDigits' => '1',
        'retries' => '1'
    }
    getDigits = r.GetDigits(params)

    getDigits.addSpeak($IVR_MESSAGE1)
    r.addSpeak($NO_INPUT_MESSAGE)

    puts r.to_xml()
    content_type 'text/xml'
    return r.to_s()

end








def tre

$PLIVO_SONG = "https://s3.amazonaws.com/plivocloud/music.mp3"

# This is the message that Plivo reads when the caller dials in


$IVR_MESSAGE2 = "Press 1 for English. Press 2 for French. Press 3 for Russian"
# This is the message that Plivo reads when the caller does nothing at all
$NO_INPUT_MESSAGE = "Sorry, I didn't catch that. Please hangup and try again later."

# This is the message that Plivo reads when the caller inputs a wrong number.
$WRONG_INPUT_MESSAGE = "Sorry, it's wrong input."

@digit = params[:Digits]
puts "sanjeev kumar yadav"
@r = Response.new()

if (@digit == "1")
    getdigits_action_url = "https://morning-peak-65848.herokuapp.com/widgets/tree"
    params = {
        'action' => getdigits_action_url,
        'method' => 'GET',
        'timeout' => '7',
        'numDigits' => '1',
        'retries' => '1'
    }
     getDigits = @r.GetDigits(params)

     getDigits.addSpeak($IVR_MESSAGE2)
    @r.addSpeak($NO_INPUT_MESSAGE)

elsif (@digit == "2")
  body = "This message is being read out in English"
          params = {
              'language'=> "en-GB"
          }

          @r.addSpeak(body,params)
    @r.addPlay($PLIVO_SONG)
else
    @r.addSpeak($WRONG_INPUT_MESSAGE)
end

 puts @r.to_xml()
 content_type 'text/xml'
 return @r.to_s()


end





def tree
  digit = params[:Digits]

  r = Response.new()

  if (digit == "1")
      body = "This message is being read out in English"
      params = {
          'language'=> "en-GB"
      }

      r.addSpeak(body,params)
  elsif (digit == "2")
      body = "Ce message est lu en français"
      params = {
          'language'=> "fr-FR"
      }

      r.addSpeak(body,params)
  elsif (digit == "3")
      body = "Это сообщение было прочитано в России"
      params = {
          'language'=> "ru-RU"
      }

      r.addSpeak(body,params)
  else
      r.addSpeak($WRONG_INPUT_MESSAGE)
  end

  puts r.to_xml()
  content_type 'text/xml'
  return r.to_s()

end

end
