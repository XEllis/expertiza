module AutomaticReviewMappingHelper
	class AutomaticReviewMapping
		
		attr_accessor :student_review_num, :submission_review_num, :calibrated_artifacts_num, :uncalibrated_artifacts_num, :assignment_id, :participants, :teams, :max_team_size
		
		def initialize(params)
		# Set instance variables to the values obtained from the params
			@student_review_num = params[:num_reviews_per_student].to_i
    		@submission_review_num = params[:num_reviews_per_submission].to_i
    		@calibrated_artifacts_num = params[:num_calibrated_artifacts].to_i
    		@uncalibrated_artifacts_num = params[:num_uncalibrated_artifacts].to_i
    		@assignment_id = params[:id].to_i
    		@participants = AssignmentParticipant.where(parent_id: params[:id].to_i).to_a.reject {|p| p.can_review == false }.shuffle!
    		@teams = AssignmentTeam.where(parent_id: params[:id].to_i).to_a.shuffle!
    		@max_team_size = Integer(params[:max_team_size]) # Assignment.find(assignment_id).max_team_size

		end

		def create_teams_if_team_is_empty_for_max_size_one
			if @teams.empty? and @max_team_size == 1
     			@participants.each do |participant|
        		user = participant.user
        		next if TeamsUser.team_id(assignment_id, user.id)
        		team = AssignmentTeam.create_team_and_node(assignment_id)
        		ApplicationController.helpers.create_team_users(participant.user, team.id)
        		@teams << team
                end
            end
		

		end

	end
end
