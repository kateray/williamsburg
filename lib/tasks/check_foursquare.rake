task :check_foursquare => :environment do

  ['lib/assets/neighborhoods-0.geojson', 'lib/assets/neighborhoods-1.geojson', 'lib/assets/neighborhoods-2.geojson', 'lib/assets/neighborhoods-3.geojson', 'lib/assets/neighborhoods-4.geojson'].each do |old_file|
  # ['lib/assets/neighborhoods-1.geojson'].each do |old_file|


    puts "reading file #{old_file}"

    open_file = File.read(old_file)
    data_hash = JSON.parse(open_file)

    data_hash.each_with_index do |feature, i|
      pts = []

      # puts i
      # puts feature['properties']

      if feature['properties']['placetype'] == 'Country'
        # do nothing
      elsif (feature['properties']['gn_adm0_cc'] == 'US' || feature['properties']['name_adm0'] == "United States") && feature['properties']['name_adm0'] != 'Uruguay'
        if feature['properties']['name_adm1'] == nil
          if feature['properties']['name_local'] == 'New York'
            state = 'new_york'
          end
        else
          state = feature['properties']['name_adm1']
        end

        unless state
          puts 'no state!'
          puts feature
        end
        if File.exist?("lib/assets/us/#{state.downcase.tr(" ", "_")}.geojson")
          old_data = File.read("lib/assets/us/#{state.downcase.tr(" ", "_")}.geojson")
          new_data = JSON.parse(old_data) << feature
        else
          new_data = [feature]
        end

        File.open("lib/assets/us/#{state.downcase.tr(" ", "_")}.geojson","w") do |new_file|
          new_file.puts JSON.pretty_generate(new_data)
        end
      else
        # puts i
        # puts feature['properties']
        if feature['properties']['gn_adm0_cc'] == nil
          if feature['properties']['name_adm0'] == 'Chile'
            country_code = 'cl'
          elsif feature['properties']['name_adm0'] == 'Venezuela'
            country_code = 've'
          elsif feature['properties']['name_adm0'] == 'Brasil'
            country_code = 'br'
          elsif feature['properties']['name_adm0'] == 'Australia'
            country_code = 'au'
          elsif feature['properties']['name_adm0'] == 'South Africa'
            country_code = 'za'
          elsif feature['properties']['name_adm0'] == 'India'
            country_code = 'in'
          elsif feature['properties']['name_adm0'] == 'New Zealand'
            country_code = 'nz'
          elsif feature['properties']['name_adm0'] == 'Malaysia'
            country_code = 'my'
          elsif feature['properties']['name_adm0'] == 'Canada'
            country_code = 'ca'
          elsif feature['properties']['name_adm0'] == 'United Kingdom'
            country_code = 'gb'
          elsif feature['properties']['name_adm0'] == 'Aruba'
            country_code = 'aw'
          elsif feature['properties']['name_adm0'] == 'Barbados'
            country_code = 'bb'
          elsif feature['properties']['name_adm0'] == 'Cayman Islands'
            country_code = 'ky'
          elsif feature['properties']['name_adm0'] == 'Cuba'
            country_code = 'cu'
          elsif feature['properties']['name_adm0'] == 'República Dominicana'
            country_code = 'do'
          elsif feature['properties']['name_adm0'] == 'Curaçao'
            country_code = 'cw'
          elsif feature['properties']['name_adm0'] == 'Bonaire Saint Eustatius and Saba'
            country_code = 'bq'
          elsif feature['properties']['name_adm0'] == 'Gibraltar'
            country_code = 'gi'
          elsif feature['properties']['name_adm0'] == 'Monaco'
            country_code = 'mc'
          elsif feature['properties']['name_adm0'] == 'Ireland'
            country_code = 'ie'
          elsif feature['properties']['name_adm0'] == 'Deutschland'
            country_code = 'de'
          elsif feature['properties']['name_adm0'] == 'Italia'
            country_code = 'it'
          elsif feature['properties']['name_adm0'] == 'Nederland'
            country_code = 'nl'
          elsif feature['properties']['name_adm0'] == 'España'
            country_code = 'es'
          elsif feature['properties']['name_adm0'] == 'Schweiz'
            country_code = 'ch'
          elsif feature['properties']['name_adm0'] == 'Belgique'
            country_code = 'be'
          elsif feature['properties']['name_adm0'] == 'الجزائر'
            country_code = 'dz'
          elsif feature['properties']['name_adm0'] == 'المغرب'
            country_code = 'ma'
          elsif feature['properties']['name_adm0'] == 'Norge'
            country_code = 'no'
          elsif feature['properties']['name_adm0'] == 'Germany'
            country_code = 'de'
          elsif feature['properties']['name_adm0'] == 'México'
            country_code = 'mx'
          elsif feature['properties']['name_adm0'] == 'Malta'
            country_code = 'mt'
          elsif feature['properties']['name_adm0'] == 'Polska'
            country_code = 'pl'
          elsif feature['properties']['name_adm0'] == 'Österreich'
            country_code = 'at'
          elsif feature['properties']['name_adm0'] == 'Suomi'
            country_code = 'fi'
          elsif feature['properties']['name_adm0'] == 'Česká republika'
            country_code = 'cz'
          elsif feature['properties']['name_adm0'] == '臺灣'
            country_code = 'tw'
          elsif feature['properties']['name_adm0'] == '한국'
            country_code = 'kr'
          elsif feature['properties']['name_adm0'] == '日本'
            country_code = 'jp'
          elsif feature['properties']['name_adm0'] == 'Turkey'
            country_code = 'tr'
          elsif feature['properties']['name_adm0'] == 'السعودية'
            country_code = 'sa'
          elsif feature['properties']['name_adm0'] == 'Russia'
            country_code = 'ru'
          elsif feature['properties']['name_adm0'] == 'Tajikistan'
            country_code = 'tj'
          elsif feature['properties']['name_adm0'] == 'Philippines'
            country_code = 'ph'
          elsif feature['properties']['name_adm0'] == 'Ελλάδα'
            country_code = 'gr'
          elsif feature['properties']['name_adm0'] == 'Sverige'
            country_code = 'se'
          elsif feature['properties']['name_adm0'] == 'România'
            country_code = 'ro'
          elsif feature['properties']['name_adm0'] == 'Israel'
            country_code = 'il'
          elsif feature['properties']['name_adm0'] == 'مصر'
            country_code = 'eg'
          elsif feature['properties']['name_adm0'] == 'Palestine'
            country_code = 'ps'
          elsif feature['properties']['name_adm0'] == 'Latvija'
            country_code = 'lv'
          elsif feature['properties']['name_adm0'] == 'Danmark'
            country_code = 'dk'
          elsif feature['properties']['name_adm0'] == 'الكويت'
            country_code = 'kw'
          elsif feature['properties']['name_adm0'] == 'البحرين'
            country_code = 'bh'
          elsif feature['properties']['name_adm0'] == 'Magyarország'
            country_code = 'hu'
          elsif feature['properties']['name_adm0'] == 'Ukraine'
            country_code = 'ua'
          elsif feature['properties']['name_adm0'] == '中國'
            country_code = 'cn'
          elsif feature['properties']['name_adm0'] == '香港'
            country_code = 'hk'
          elsif feature['properties']['name_adm0'] == 'Myanmar'
            country_code = 'mm'
          elsif feature['properties']['name_adm0'] == 'الامارات'
            country_code = 'ae'
          elsif feature['properties']['name_adm0'] == 'Bosna i Hercegovina'
            country_code = 'ba'
          elsif feature['properties']['name_adm2'] == 'New Delhi'
            country_code = 'in'
          end
        else
          if feature['properties']['name_adm0'] == 'Uruguay'
            country_code = 'uy'
          else
            country_code = feature['properties']['gn_adm0_cc']
          end
        end

        unless country_code
          puts 'no country!'
          puts feature['properties']
        end

        if File.exist?("lib/assets/#{country_code.downcase}.geojson")
          old_data = File.read("lib/assets/#{country_code.downcase}.geojson")
          new_data = JSON.parse(old_data) << feature
        else
          new_data = [feature]
        end

        File.open("lib/assets/#{country_code.downcase}.geojson","w") do |new_file|
          new_file.puts JSON.pretty_generate(new_data)
        end
      end

    end

  end

end
