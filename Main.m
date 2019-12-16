person=1;
fragment=1;
ex=exist('tag','var');
if ex == 0 || tag(1) ~= person || tag(2) ~= fragment
    [audio_full, fs2, data2, data]=Import(person,fragment);
    tag=[person fragment];
end
[audio,eeg] = Preprocessing(audio_full, fs2, data2, data,person,fragment);
tmin = 0;
tmax = 250*32/1000;
S = st_matrix(audio,tmin,tmax);
SS=[S;S;S;S];

cor=zeros(5,64);
for j=1:5
    eegg=[eeg((mod(j,5)+1)).eeg eeg((mod(j+1,5)+1)).eeg eeg((mod(j+2,5)+1)).eeg eeg((mod(j+3,5)+1)).eeg];
    w=TRF(SS,eegg);
    Y=S*w;
    for i=1:64
       cor(j,i)=corr(Y(:,i),eeg(j).eeg(i,:)');
    end
end

