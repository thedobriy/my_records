class Record < ActiveRecord::Base  
  def self.import(file)
    tempDate = ""
    my_array = []
    # labels
    # P = paragraf 13
    # K = kinomehanik
    # B = bunker
    # RA - arenda
    # RZ - зарплата
    # RK - Коммунальные
    # RT - Текущие
    # D - доход
    # S - sertifikat
    # A - abonement
    par13_array = ["11:00", "12:20", "13:40", "15:00", "16:20", "17:40", "19:00", "20:20", "21:40"]
    bunker_array = ["11:10", "12:30", "13:50", "15:10", "16:30", "17:50", "19:10", "20:30", "21:50"]
    kino_array = ["11:30", "12:50", "14:10", "15:30", "16:50", "18:10", "19:30", "20:50"]
    CSV.foreach(file.path, :col_sep => (";"), headers: true) do |row|
      label = ""
      if (row[0] == nil && row[1] == nil) then # проверка на пустые строки
        next 
      end
      if (row[0].to_s.first(3) == "Ост") then # записи с Остатком пропускаем
        hash = {datetime: row[0], summa: row[1], desc: row[2]}
        my_array.push(hash)
        next
      end
      if (row[0] == nil && row[1] != nil) then # проверка на пустые строки
        row[0] = Date.parse(tempDate).to_s
      end
      if row[2] =~ /аренд/i then
        label = "RA"
      end
      if row[2] =~ /абонем/i then
        label = "A"
      end
      if row[2] =~ /сертиф/i then
        label = "S"
      end
      if (row[2] =~ /зп /i || row[2] =~ /катя/i || row[2] =~ /зарплат/i || row[2] =~ /кате/i ) then
        label = "RZ"
      end   
   
      summa = row[1].to_i

      if (summa.to_i < 0) then
        summa *= -1
        label = "RK" if (row[2] =~ /коммуна/i)       
        label = "RT" if (row[2] =~ /уборк/i)
        label = "RT" if (label == "")
        label = "D" if (row[2] =~ /по /i)        
      end 
      dt = DateTime.parse(row[0])
      if (par13_array.any? { |elem| elem.to_s == dt.strftime("%H:%M").to_s }) then
        label = "P"
      end
      if (bunker_array.any? { |elem| elem.to_s == dt.strftime("%H:%M").to_s }) then
        label = "B"
      end
      if (kino_array.any? { |elem| elem.to_s == dt.strftime("%H:%M").to_s }) then
        label = "K"
      end
      if (label == "") then # записи без метки пропускаем
        hash = {datetime: row[0], summa: row[1], desc: row[2]}
        my_array.push(hash)
        next
      end      
      #  date = Date.parse(row[0])
      # time = Time.parse(row[0]).zone
      tempDate = row[0]
      Record.where({datetime: dt, summa: summa, 
        desc: row[2], label: label}).first_or_create
    end
    # скидываем необработанные записи в отдельный файл
    @file = "out_" + Time.now.strftime('%Y-%m-%d_%H-%M-%S') + ".csv"
    CSV.open(@file, "wb") do |csv|
      my_array.each do |row| 
        csv << row.values 
      end
    end
  end
end
