class Report
  
  def reports(current_user)
      
    subject_question_hash_by_id=current_user.questions.group(:subject_id).size
    subject_question_hash_by_name={}
    subject_question_hash_by_id.keys.each {|k| subject_question_hash_by_name[Subject.find(k).subject] = subject_question_hash_by_id[k]}
    subject_question_hash_by_name.keys.each {|k| subject_question_hash_by_name[k]}
    array_of_subjects = []
    array_of_number_of_questions = []
    subject_question_hash_by_name.keys.each {|k| array_of_subjects.push(k)}
    subject_question_hash_by_name.keys.each {|k| array_of_number_of_questions.push(subject_question_hash_by_name[k])}
    graph = nil   
    color_1 = 'c53711'
    GoogleChart::BarChart.new("250x160", "Horizontal Bar Graph", :horizontal, false) do |bc| 
      # for i in 0..array_of_subjects.count
        bc.data "Total Questions", array_of_number_of_questions, color_1
        bc.show_legend = false
        bc.axis :y, :labels => array_of_subjects.reverse, :font_size => 10
        bc.axis :x, :range => [0,array_of_number_of_questions.max]
        bc.stacked = false
        bc.data_encoding = :extended
        bc.shape_marker :circle, :color => '00ff00', :data_set_index => 0, :data_point_index => -1, :pixel_size => 10        
      # end  
        graph = bc.to_url 
    end
    return graph
  end

end