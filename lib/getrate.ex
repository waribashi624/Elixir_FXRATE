defmodule Getrate do
    def main(args) do

        pair = Enum.at(args, 0)
        min = Enum.at(args, 1)
        time = HTML_Parse.get_time()
        
        cond do
            time[:min] == min -> nil
        
            rem(time[:second],60) == 0 ->
            rate = HTML_Parse.get_HTML(pair)
            {:ok, file} = File.open "Rate.csv", [:append]
            IO.binwrite file, "#{time[:month]}/#{time[:day]},#{time[:hour]},#{time[:min]},#{time[:second]},#{pair},#{rate}\n"
            IO.puts "check"
            File.close file
            
            true -> nil
        end
        main([pair,time[:min]])
    end
end

defmodule HTML_Parse do
@base_url "http://info.finance.yahoo.co.jp/fx/detail/?code="
@attempt_url "=FX"
HTTPotion.start

    def get_HTML(pair) do

        url = @base_url <> pair <> @attempt_url
        html = HTTPotion.get url
        html_body = html.body
        id = "#" <> pair <> "_detail_bid"
        raw = Floki.find(html_body, id)
        raw = Enum.at(raw, 0)
        raw = elem(raw, 2)
        int = Enum.at(raw, 0)
        raw = Enum.at(raw, 1)
        raw = elem(raw, 2)
        float = Enum.at(raw, 0)
        rate = int <> float
        
        rate
    end
    
    def get_time() do
        time = :calendar.local_time
        month = elem(time, 0)
        |> elem(1)
        day = elem(time, 0)
        |> elem(2)
        hour = elem(time,1)
        |> elem(0)
        min = elem(time, 1)
        |> elem(1)
        second = elem(time, 1)
        |> elem(2)
        
        %{month: month, day: day, hour: hour, min: min, second: second}
        end
end    


        
        
