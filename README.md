# Make All Your S3 Files Private

All of your S3 files are wide open to the world and you want to lock it down. You've come to the right place.

## Let's Go
1. Clone this repository to your machine. `git clone https://github.com/plicjo/privatize_s3_files`
2. Navigate to the cloned repository. `cd privatize_s3_files`
3. Install bundler. `gem install bundler`
4. Bundle `bundle`
5. Create a `.env` file. Populate it with: `S3_ACCESS_KEY_ID`, `S3_BUCKET`, and `S3_SECRET_ACCESS_KET`
6. Run *privatize.rb* and all your files should be private now. `ruby privatize.rb`
