MultimediaAnalysis
==================

The code for multimedia analysis,especially for multimedia event detection
/sb is the code for shot boundary detection. we use the frame work for shot boundary detection in paper 
(cf."A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007)
first the color histogram is used to calculate the continuity between frames,then the edge change ratio is used 
to remove the wrong recall of cut. This algorithm is efficient in calculate cut(dataset is trecvid 2002).
