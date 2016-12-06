w=importdata('w.mat')

num_frames_per_second = 1;
  aviobj = avifile ( 'PPF_40.avi', 'fps', num_frames_per_second ); 

  for i =  1 : 10
      imshow(0.1*w(:,:,i));
    frame = getframe ( gca );
    aviobj = addframe ( aviobj, frame );
  end
%
%  Tell MATLAB we have completed the movie.
%
  aviobj = close ( aviobj );
 