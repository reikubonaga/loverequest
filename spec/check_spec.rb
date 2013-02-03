# coding: utf-8

require 'pry'
require 'json'

def calc_score(answers)
  questions = {"デートはどこで遊びたいですか？"=>{"映画館"=>"2", "カラオケ"=>"-1", "遊園地"=>"1", "家"=>"0"}, "どんな性格がいいですか？"=>{"優しい"=>"2", "面白い"=>"1", "可愛い"=>"-1", "静か"=>"0"}, "facebookの友人は何人いますか？"=>{" 150人以下"=>"-1", " 150人以上"=>"1", " 500人以上"=>"2", " 1000人以上"=>"1"}, "私の好きな食べ物は何でしょうか？"=>{" チョコ"=>"-1", " はちみつ梅干し"=>"2", " ケンタッキーフライドチキン"=>"-2", " いちご"=>"1"}}
  total = 1
  questions.keys.each do |q|
    a = answers[q]
    total += questions[q][a] || -1
  end
  total
end

describe "Men's points" do
  it "passing" do
    passing_point = 5
    Dir.glob("spec/passing/*") do |file|
      username = file.split('/').last
      next if username.include?(".sample")
      io = open(file)
      answers = {}
      io.each do |l|
        q, sep, a = l.strip.rpartition(': ')
        if sep.empty?
          raise "invalid format"
        end
        answers[q] = a
      end
      score = calc_score(answers)
      puts "#{username}'s score: #{score}"
      score.should >= passing_point
    end
  end
end

