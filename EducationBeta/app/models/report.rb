class Report
  
  def report_filter_questions_by_subject_for_an_user(current_user)
      
    subject_question_hash_by_id=current_user.questions.group(:subject_id).size
    subject_question_hash_by_name={}
    subject_question_hash_by_id.keys.each {|k| subject_question_hash_by_name[Subject.find(k).subject] = subject_question_hash_by_id[k]}
    subject_question_hash_by_name.keys.each {|k| subject_question_hash_by_name[k]}
    array_of_subjects = []
    array_of_number_of_questions = []
    subject_question_hash_by_name.keys.each {|k| array_of_subjects.push(k)}
    subject_question_hash_by_name.keys.each {|k| array_of_number_of_questions.push(subject_question_hash_by_name[k])}
    graph = nil   
    color_1 = 'FBB917'
    GoogleChart::BarChart.new("250x160", "Number of Questions by Subject", :horizontal, true) do |bc| 
      # for i in 0..array_of_subjects.count
        bc.data "Total Questions", array_of_number_of_questions, color_1
        bc.show_legend = false
        bc.axis :y, :labels => array_of_subjects.reverse, :font_size => 10
        bc.axis :x, :range => [0,array_of_number_of_questions.max]
        bc.stacked = true
        bc.data_encoding = :extended
        bc.shape_marker :circle, :color => '000000', :data_set_index => 0, :data_point_index => -1, :pixel_size => 10        
      # end  
        graph = bc.to_url 
    end
    return graph
  end
  
  def report_filter_answered_questions_by_subject_for_an_user(current_user)
      
    questions_by_sub_by_status=current_user.questions.group(:status,:subject_id).where(:status => 'answered').size
    number_of_answered_questions_by_subname={}
    questions_by_sub_by_status.keys.each{|k| number_of_answered_questions_by_subname[Subject.find(k[1]).subject]=questions_by_sub_by_status[k]}  
    array_of_subjects = []
    array_of_number_of_questions = []
    number_of_answered_questions_by_subname.keys.each{|k| array_of_subjects.push(k)}
    number_of_answered_questions_by_subname.keys.each{|k| array_of_number_of_questions.push(number_of_answered_questions_by_subname[k])}

    graph = nil   
    color_1 = '9ACD32'
    GoogleChart::BarChart.new("250x160", "Questions Answered by Subject", :horizontal, true) do |bc| 
      # for i in 0..array_of_subjects.count
        bc.data "Total Questions", array_of_number_of_questions, color_1
        bc.show_legend = false
        bc.axis :y, :labels => array_of_subjects.reverse, :font_size => 10
        bc.axis :x, :range => [0,array_of_number_of_questions.max]
        bc.stacked = true
        bc.data_encoding = :extended
        bc.shape_marker :circle, :color => '000000', :data_set_index => 0, :data_point_index => -1, :pixel_size => 10        
      # end  
        graph = bc.to_url 
    end
    return graph
  end
  
  def report_line_graph(current_user)
      
    questions_answered_date=current_user.questions.group(:updated_at).where(:status => 'answered').size
    answered_by_months=[]
    questions_answered_date.keys.each{|k| answered_by_months.push(k.strftime("%b %Y"))}
    
    months_array=[]
    number_of_questions_array=[]
    
    answered_by_months.each do |i|
      next if months_array.include?(i) 
      months_array<<i
      number_of_questions_array<<answered_by_months.select{|b| b==i}.size
    end
    
    graph = nil   
    color_1 = '4169E1'
    lc = GoogleChart::LineChart.new("900x300", "Number of questions answered by Months", false)
    lc.data "Line green", number_of_questions_array, color_1
    lc.axis :y, :range => [0,number_of_questions_array.max], :font_size => 10, :alignment => :center
    lc.axis :x, :labels => months_array, :font_size => 10
    lc.show_legend = false
    lc.shape_marker :circle, :color => '000000', :data_set_index => 0, :data_point_index => -1, :pixel_size => 10
    graph=lc.to_url


    return graph
  end  

  def dummy_report(current_user)
    graph = nil
    GoogleChart::PieChart.new('290x200', "Your Hold on Subjects",false) do |pc| 
      pc.data "Maths", 60 , "9ACD32"
      pc.data "Physics", 40 , "FBB917"
      pc.data "Chemistry", 20 , "357EC7"
      pc.data "Biology", 20 , "E55B3C"
      pc.show_labels = true
      graph = pc.to_url 
    end

    return graph
  end

end