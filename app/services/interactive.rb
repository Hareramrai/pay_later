class Interactive < ApplicationService
  def call 
    puts "Please enter your command!"
    loop do
      command = gets.chomp
      break if command.casecmp('exit').zero?

      execute(command)
    end
  end 

  private 

  def execute(command)
    command_action, command_fields = parse_raw_command(command)

    if command_action == "new" 
      sub_command_action, sub_command_fields = parse_raw_command(command_fields.join(" "))
      manage_new_command(sub_command_action, sub_command_fields)
    else
      puts "Not supported yet!"
    end
  end

  def parse_raw_command(raw_command)
    command_fields = raw_command.split(/\s/)
    command_action = command_fields.shift
  
    [command_action, command_fields]
  end

  def manage_new_command(sub_command_action, fields)
    case sub_command_action
    when "user"
      user = Users::CreateUser.call(name: fields[0], email: fields[1], credit_limit: fields[2])
      p user
    when "merchant"
      merchant = Merchants::CreateMerchant.call(name: fields[0], discount: fields[1])
      p merchant
    when "txn"
      transaction = Transactions::CreateTransaction.call(
        user_name: fields[0], merchant_name: fields[1], amount: fields[2]
      )
      p transaction
    else
      raise "Command not supported yet!"
    end
  end
end


