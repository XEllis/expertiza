module AutomaticReviewMappingHelper
	class AutomaticReviewMapping
		attr_accessor :student_review_num, :submission_review_num, :calibrated_artifacts_num, :uncalibrated_artifacts_num
		def set_parameters(params)
			@student_review_num = params[:num_reviews_per_student].to_i
    		@submission_review_num = params[:num_reviews_per_submission].to_i
    		@calibrated_artifacts_num = params[:num_calibrated_artifacts].to_i
    		@uncalibrated_artifacts_num = params[:num_uncalibrated_artifacts].to_i
    	end
    end
end
