
t = 0:100;
s = fotf('s');

tf = 1/s^0.5;

tf_feed = feedback(tf,1)
u=ones(1,length(t));

figure(1)
impulse(tf_feed, t)

y = lsim(tf_feed, u, t);
figure(2)
plot(t,y)

tf_ostalup = ostaapp(tf_feed);
y = lsim(tf_ostalup, u, t);
plot(t,y)