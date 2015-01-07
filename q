
[1mFrom:[0m /home/wn3/Dropbox/projects/2not-funny/not_funny/app/controllers/comments_controller.rb @ line 15 CommentsController#create:

    [1;34m11[0m: [32mdef[0m [1;34mcreate[0m
    [1;34m12[0m:   binding.pry
    [1;34m13[0m:   @commentable = find_commentable
    [1;34m14[0m:   @comment = @commentable.comments.build(comment_params)
 => [1;34m15[0m:   [32mif[0m @comment.save
    [1;34m16[0m:     flash[[33m:notice[0m] = [31m[1;31m"[0m[31mSuccessfully created comment.[1;31m"[0m[31m[0m
    [1;34m17[0m:     redirect_to @commentable
    [1;34m18[0m:   [32melse[0m
    [1;34m19[0m:     flash[[33m:error[0m] = [31m[1;31m"[0m[31mError adding comment.[1;31m"[0m[31m[0m
    [1;34m20[0m:   [32mend[0m
    [1;34m21[0m: [32mend[0m

