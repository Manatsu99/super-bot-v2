# サモリフ

require 'discordrb'
require 'resolv'

#require 'dotenv'

#Dotenv.load
admin = ENV["USER_ADMIN"]

discord_id=ENV["DISCORD_ID"]
discord_token=ENV["DISCORD_TOKEN"]

ip_addr_str = Resolv::DNS.new(:nameserver=>'ns1.google.com').getresources("o-o.myaddr.l.google.com", Resolv::DNS::Resource::IN::TXT)[0].strings[0]

bot = Discordrb::Commands::CommandBot.new(
    client_id: discord_id,
    token: discord_token,
    prefix:'/',
    name: 'SUPER-BOT2'
)

bot.command :hello do |event|
  event.send_message("hello, world.")
  event.send_message("#{event.user.name}")
  event.send_message("#{event.user.id}")
  event.send_message(ip_addr_str)
end

bot.command(:region, chain_usable: false, description: "Gets the region the server is stationed in.", permission_level: 0) do |event|
  event.server.region
end

bot.command :recruit do |event, menber, minutes|
  
end

bot.command :test do |event|
  event.send.message("This is test.\n I am #{event.bot.name}")
end

bot.command(:setGame) do |event, game|
  bot.game = game
  nil
end

bot.command :resetGame do |event|
  bot.game = nil
  nil
end
=begin
bot.voice_state_update do |event|
  if !event.user.bot_account
    # get default text channel
    begin
      default_text_channel = nil
      event.server.channels.each do |channel|
        if channel.type.zero?
          default_text_channel ||= channel.id
          default_text_channel = channel.id if channel.name == 'general'
        end
      end
      exit unless default_text_channel
    rescue SystemExit => err
      puts "[WARN] There is no text channel."
    end

    # notify only when joining any channel
    if event.old_channel.nil?
      # text notification
      text = "#{event.user.name} joined #{event.channel.name}"
      event.bot.send_message(default_text_channel, text)
    end
  end
end
=end

bot.command(:shutdown) do |event|
  break unless event.user.id == admin
  bot.send_message(event.channel.id, 'Bot is shutting down')
  exit
end

bot.command :dev do |e|
  e.send_message("#{e.user.id}")
  e.send_message("#{admin}")
  if "#{e.user.id}" == "#{admin}"
    e.send_message("dev")
  else
    e.send_message("cannot")
  end
end

bot.command :embedTest  do |e1|
  e1.send_embed do |e2|
    e2.title = "募集"
    e2.url = nil
    e2.colour = 0xFF8800 #オレンジ
    e2.description = "description"
    e2.add_field(
      name: "field name left",
      value: "field value left",
      inline: true
    )
    e2.add_field(
      name: "field name right",
      value: "field value right",
      inline: true
    )
    e2.add_field(
      name: "field name under",
      value: "field value under",
      inline: false
    )
    e2.timestamp = Time.now
    e2.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://www.ruby-lang.org/images/header-ruby-logo.png')
    e2.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: 'https://discordapp.com/assets/e7a3b51fdac2aa5ec71975d257d5c405.png')
    e2.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "footer",
      icon_url: 'https://discordapp.com/assets/28174a34e77bb5e5310ced9f95cb480b.png'
    )
    e2.author = Discordrb::Webhooks::EmbedAuthor.new(
      name: 'Manatsu99',
      url: 'https://manatsu99.github.io',
      icon_url: 'https://qiita-image-store.s3.amazonaws.com/0/122913/profile-images/1532764209'
    )
  end
end

bot.command :t01, description: "/t01 min member" do |e1, minute, member|
  if minute.nil?
    minute = 120
  end
  if member.nil?
    member = "Any"
  end

  #user設定
    #sName:Summoner's Name(ゲーム内名前)
    #cName:Champion's Name
    #colour:募集色
    if "#{e1.user.id}" == admin
      #Manatsu99
      sName="Manatsu99"
      cName="Ahri.png"
      colour="0xFFFFFF"
    else
      sName="None"
      cName="Sylas.png"
      colour="0xFF8800"
    end
  #画像設定
    url="https://your.gg/jp/summoner?s="
    icon="https://ddragon.leagueoflegends.com/cdn/9.21.1/img/champion/"
  #e2.main
  e1.send_embed do |e2|
    e2.title = "LoL募集"
    e2.url = "https://jp.op.gg/champion/statistics"
    e2.colour = "#{colour}"#オレンジ
    e2.description = "サモナーズリフト"
    e2.add_field(
      name: 'おなまえ',#{e1.user.name}",
      value: "#{e1.user.name}",#"#{e1.user.id}",
      inline: true
    )
    e2.add_field(
      name: "時間",
      value: "#{minute}分",
      inline: true
    )
    e2.add_field(
      name: "人数",
      value: "#{member}人",
      inline: false
    )
    e2.timestamp = Time.now
    e2.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://cdn.discordapp.com/attachments/638966678373531648/639330815011979264/xCzZMrT.png')
    e2.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: 'https://cdn.discordapp.com/attachments/638966678373531648/639331608834473994/47210.png')
    e2.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "サモナーズリフトへようこそ！",
      icon_url: "#{icon+'Teemo.png'}"
    )
    e2.author = Discordrb::Webhooks::EmbedAuthor.new(
      name: "#{e1.user.name}",
      url: "#{url+sName}",
      icon_url: "#{icon+cName}"
    )
  end
end

bot.command :t02, description: "/t02 min member" do |e1, minute, member|
  if minute.nil?
    minute = 120
  end
  if member.nil?
    member = "Any"
  end

  #user設定
    #sName:Summoner's Name(ゲーム内名前)
    #cName:Champion's Name
    #colour:募集色
    if "#{e1.user.id}" == admin
      #Manatsu99
      sName="Manatsu99"
      cName="Ahri.png"
      colour="0xFFFFFF"
    else
      sName="Null"
      cName="Tristana.png"
      colour="0xFF8800"
    end
  #画像設定
    url="https://your.gg/jp/summoner?s="
    icon="https://ddragon.leagueoflegends.com/cdn/9.21.1/img/champion/"
  #e2.main
  e1.send_embed do |e2|
    e2.title = "LoL募集"
    e2.url = "https://jp.op.gg/champion/statistics"
    e2.colour = "#{colour}"#オレンジ
    e2.description = "サモナーズリフト"
    e2.add_field(
      name: 'おなまえ',#{e1.user.name}",
      value: "#{e1.user.name}",#"#{e1.user.id}",
      inline: true
    )
    e2.add_field(
      name: "時間",
      value: "#{minute}分",
      inline: true
    )
    e2.add_field(
      name: "人数",
      value: "#{member}人",
      inline: false
    )
    e2.timestamp = Time.now
    e2.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://cdn.discordapp.com/attachments/638966678373531648/639330815011979264/xCzZMrT.png')
    e2.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: 'https://cdn.discordapp.com/attachments/638966678373531648/639331608834473994/47210.png')
    e2.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "サモナーズリフトへようこそ！",
      icon_url: "#{icon+'Teemo.png'}"
    )
    e2.author = Discordrb::Webhooks::EmbedAuthor.new(
      name: "#{e1.user.name}",
      url: "#{url+sName}",
      icon_url: "#{icon+cName}"
    )
  end
  #if e1.reaction_add
  #  member.to_i--
  #  e2.field[2].value= "残り#{member}人"
  #end
end

#完成
bot.command :champion, description: "/champion cName lName" do |e, cName, lName|
  opgg = 'https://jp.op.gg/champion/'
  ugg = 'https://u.gg/lol/champions/'
  e.send_message("#{opgg+cName}/statistics/#{lName}")
  e.send_message("#{ugg+cName}/build?role=#{lName}")
end

bot.run