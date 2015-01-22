class Api::KindeditorController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def upload
		@error = 0
		@url = ''
		@message = ''


		valide_extnames = {
			:image => [".gif", ".jpg", ".jpeg", ".png", ".bmp"],
			:flash => [".swf", ".flv"],
			:media => [".swf", ".flv", ".mp3", ".wav", ".wma", ".wmv", ".mid", ".avi", ".mpg", ".asf", ".rm", ".rmvb"],
			:file => [".doc", ".docx", ".xls", ".xlsx", ".ppt", ".htm", ".html", ".txt", ".zip", ".rar", ".gz", ".bz2"]
		}

		uploaded_io = params[:imgFile]
		extname = File.extname(uploaded_io.original_filename)

		dir = params[:dir]

		if !valide_extnames[dir.to_sym].include?(extname)
			render :text => ({:error => 1, :message => '上传文件的类型不合法'}.to_json)
			return
		end

		time = Time.now
		newfilename = time.to_s(:number) + time.nsec.to_s + extname

		des_dir = Rails.root.join('public', 'uploads', dir)
		if !File.exist?(des_dir)
			Dir.mkdir(des_dir)
		end

		des_dir = des_dir.join("#{time.year}#{time.month}")

		if !File.exist?(des_dir)
			Dir.mkdir(des_dir)
		end

    filename = des_dir.join(newfilename)

    begin
	    File.open(filename, 'wb') do |file|
	      file.write(uploaded_io.read)
	    end

	    @url = request.protocol + request.host_with_port + '/uploads/' + dir + "/#{time.year}#{time.month}" + '/' + newfilename

	    render layout: false
	    #render :text => ({:error => 0, :url => url}.to_json)
	  rescue
		  render :text => ({:error => 1, :message => $1}.to_json)
		end
	end
end
