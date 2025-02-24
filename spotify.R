require(ggplot2)
require(viridis)
require(dplyr)
require(gt)


#cleaning/setting up
data<-read.csv(file.choose())

data$Instrumentalness<-NULL


data$Genres<-as.factor(data$Genres)

data$Release.Date<-as.Date(data$Release.Date)


data2<-read.csv(file.choose())


summary(data)
data2<-read.csv(file.choose())
data2$Key
data$Key<-data2$Key
head(data2)
data[164,]
data<-data[-162,]
data
rownames(data)<-NULL
data$Key
remove(data2)

summary(data)
data<-data[-10,]
data[75,]
data[which.max(data$Danceability),]
summary(data) # i need to clear the repeat tracks

ggplot(data=data, aes(x=Tempo,y=Energy))+geom_point(color="black")+geom_smooth(method = "lm", color = "blue")

YenergyXtempo <- lm(Energy ~ Tempo, data=data) #checking coefficient line
summary(YenergyXtempo)   

#finding that outlier
filter(data, Tempo<75 & Energy>.50)


#ok time to separate within a list

data[data$Genres=="midwest emo"]
filter(data,Genres=="midwest emo")
summary(data$Genres)

filter(data,Artist.Name.s.=="They Might Be Giants")

#difficulties with recategorizing
# some artists are niche per spotify - wtf is "gen z singer songwriter" for laufey or "art rock" for radiohead
# soundtrack tunes are hard to sort - HSM/La La Land/Schoolhouse Rock
# i categorized all as "hollywood" from movies BUT i differentiated between made for TV/TV soundtracks
#sometimes small artists don't have - such as fai laci (who i coded as indie rock)
  #as such, i chose to code "AN4L" as "comedy rock"

newcol<-read.csv(file.choose())
newcol$Genres
data$Genres<-newcol$Genres
data$Genres<-as.factor(data$Genres)
summary(data)
remove(newcol)

#check relationship between genre and popularity?

ggplot(data=filter(data,Genre=="midwest emo"|Genre==
                     "pop"|Genre=="pov:indie"|
                     Genre=="rap"|
                     Genre=="art pop"|
                     Genre=="alternative pop rock"|
                     Genre=="bedroom pop"|
                     Genre=="hollywood"|Genre=="indie rock"|
                     Genre=="melodic rap"|
                     Genre=="new wave"|Genre=="punk"), aes(x=Genre,y=Danceability,color=Release.Date))+geom_jitter()+geom_boxplot(alpha=.5)+theme(axis.text.x = element_text(angle = 45, hjust = 1))

#TO ROTATE LABELS: theme(axis.text.x = element_text(angle = 45, hjust = 1))

table(data$Genres)
summary(data)
colnames(data)

colnames(data)<-c("Title", "Album", "Artist", "Release.Date", "Duration", 
                  "Popularity", "Genre", "Danceability", "Energy", "Key", "Loudness",
                  "Acousticness", "Liveness", "Valence", "Tempo", "Time.Signature")


#TO DO: derivations for subsets: rap, rock, emo, punk, pop

ggplot(data=data,aes(x=Release.Date))+geom_histogram(aes(fill=BigGenre),binwidth=10,color="black")

#TO DO: SORT each into subset
data$Genre
levels(data$Genre)
data2<-data
for (x in 1:345(data2)){
  if (x == "comedy"){
    data[x]<-"FLAG"
  }
}
names(data)

?factor
?list
levels(data$Genre)
newgenres<-list(
"rock" = c("album rock", "rock", "surf rock", "soft rock", "ska", "scottish rock", "modern rock", "pop rock", "power pop", "progressive rock", "post-grunge", "mellow gold","glam metal","glam rock","heartland rock", "garage rock","geek rock","funk rock", "alternative rock", "art rock","classic rock"),
"pop" = c("alternative pop rock", "uk pop", "soft pop", "pop", "hyperpop", "shiver pop", "early synthpop", "dream pop", "dance pop", "art pop","colombian pop","canadian pop","chamber pop", "atlanta indie","baroque pop"),
"emo" = c("emo", "midwest emo", "pop punk", "punk", "folk punk"),
"new wave" ="new wave",
"rap" = c("cloud rap","hip hop","trap", "melodic rap", "pittsburgh rap", "r&b", "rage rap", "rap", "rap rock", "pop rap", "lgbtq+ hip hop", "kentucky hip hop", "dfw rap","drill","experimental hip hop","gangster rap"),
"indie" = c("jangle pop", "slc indie", "singer-songwriter", "singer-songwriter pop", "pov: indie", "nyc indie rock", "modern indie pop", "lo-fi indie","bedroom pop", "indie", "indie pop", "indie rock","indietronica", "gen z singer-songwriter", "boston indie", "chicago indie","folk","folk pop","folk rock"),
"other" = c("christmas","musicals", "soul", "reggaeton", "jazz", "comedy", "latin", "comedy rock","country","edm","flamenco","hollywood"))

summary(data$Genre)

newgenres
data2$BigGenre<-NA


for (group in names(newgenres)) {
  data2$BigGenre[df$Genre %in% newgenres[[group]]] <- group
}

data2$BigGenre
print("hello")
head(data2)

data2$BigGenre <- newgenres[as.character(data2$Genre)]
names(newgenres)
"pop rock" %in% data2$Genre
for (i in 1:345){
  if (data2$Genre[i] %in% newgenres$rock){
    data2$BigGenre[i]<-"rock"
  }
  else if (data2$Genre[i] %in% newgenres$pop){
    data2$BigGenre[i]<-"pop"
  }
  else if (data2$Genre[i] %in% newgenres$indie){
    data2$BigGenre[i]<-"indie"
  }
  else if (data2$Genre[i] %in% newgenres$emo){
    data2$BigGenre[i]<-"emo"
  }
  else if (data2$Genre[i] %in% newgenres$rap){
    data2$BigGenre[i]<-"rap"
  }
  else if (data2$Genre[i] %in% newgenres$other){
    data2$BigGenre[i]<-"other"
  }
  else if (data2$Genre[i] %in% newgenres$'new wave'){
    data2$BigGenre[i]<-"new wave"
  }
}


data$BigGenre<-NA
data$BigGenre<-data2$BigGenre

ggplot(data=filter(data,data$BigGenre!="other"), aes(x=BigGenre,y=Popularity))+geom_jitter(aes(color=Release.Date))+geom_boxplot(alpha=0.5)+xlab("Genre")

ggplot(data=filter(data,data$BigGenre!="other"), aes(x=BigGenre,y=Popularity))+geom_jitter(aes(color=DateYear))+
  geom_boxplot(alpha=0.5,outlier.shape=NA)+xlab("Genre")+labs(color="Release Year")+scale_color_distiller(palette="Spectral",direction=1)+
  ggtitle("Popularity by Genre (without Other)")
#addition of outlier.shape=NA and of filtering out "other"

data$DateFactor<-NULL
data$DateYear <- as.numeric(format(data$Release.Date, "%Y"))

sort(table(data$BigGenre), decreasing=TRUE)
#how to find most of something (mode)

sort(data$Danceability, decreasing=TRUE)
#FROM DPLYR


top_n(data,-10, Danceability)
#this is kind of ugly but shows you all the info

#let's look at the 30 least danceable songs
ggplot(data=top_n(data,-30, Danceability), aes(x=BigGenre))+
  geom_bar(color="black",fill="lightblue2")+ggtitle("Genre of 30 Least Danceable Songs")

summary(data)

#artist specific (not used)
ggplot(data=filter(data,Artist=="The Front Bottoms"), 
       aes(x=Title,y=Popularity))+geom_col(color="black",fill="purple")+
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+ylim(0,100)+xlab("Song Title")+ggtitle("TFB song popularities")



#MEAN AND SD of everything

meansd<-data.frame(Category=c("Danceability","Energy","Acousticness","Valence"),
                  Mean=c(mean(data$Danceability), mean(data$Energy), mean(data$Acousticness), mean(data$Valence)),
                  SD=c(sd(data$Danceability), sd(data$Energy), sd(data$Acousticness), sd(data$Valence))
  )

ggplot(data=meansd, aes(x=Category, y=Mean))+geom_bar(stat="identity",fill="orange",color='black')+ylim(0,1) +
  ggtitle("Means of Selected Categories")

#visualizations by Genre

mefilter<-filter(data,Genre=="midwest emo")

#midwest emo specific
memeansd<-data.frame(Category=c("Danceability","Energy","Acousticness","Valence"),
                  Mean=c(mean(mefilter$Danceability), mean(mefilter$Energy), mean(mefilter$Acousticness), mean(mefilter$Valence)),
                  SD=c(sd(mefilter$Danceability), sd(mefilter$Energy), sd(mefilter$Acousticness), sd(mefilter$Valence)))

ggplot(data=memeansd, aes(x=Category, y=Mean))+geom_bar(stat="identity",fill="wheat",color='black')+ylim(0,1) +
  ggtitle("Mean of Selected Categories (Midwest Emo Songs Only)")

#no midwest emo

nomefilter<-filter(data,Genre!="midwest emo")

#now rap is our top genre, hopefully will be more energetic - spotify loves rap

nomemeansd<-data.frame(Category=c("Danceability","Energy","Acousticness","Valence"),
                     Mean=c(mean(nomefilter$Danceability), mean(nomefilter$Energy), mean(nomefilter$Acousticness), mean(nomefilter$Valence)),
                     SD=c(sd(nomefilter$Danceability), sd(nomefilter$Energy), sd(nomefilter$Acousticness), sd(nomefilter$Valence)))

ggplot(data=nomemeansd, aes(x=Category, y=Mean))+geom_bar(stat="identity",fill="firebrick2",color='black')+ylim(0,1) +
  ggtitle("Selected Categories with Midwest Emo Removed")


#analyzing by year frequency

ggplot(data=data, aes(x=DateYear))+geom_histogram(aes(fill=BigGenre),breaks=seq(1959,2029,by=10))+
  xlim(1959,2029)+scale_fill_brewer(palette="Spectral",direction=1)+
  xlab("Release Year")+ggtitle("Recency of Playlist's Songs")+ylab("Count")+labs(col="Big Genre")

filter(data,DateYear>=2021)
filter(data,DateYear==2024)

#why are so many emo songs that are popular older?

filter(data,BigGenre=="emo")
top_n(filter(data,Genre=="midwest emo"), -10, Popularity)

#what is mean popularity for JUST midwest emo

mefilter<-filter(data,Genre=="midwest emo")
efilter<-filter(data,BigGenre==
                  "emo"&Genre!="midwest emo")
efilter2<-filter(data,BigGenre=="emo")

mean(mefilter$Popularity)
mean(efilter$Popularity)

ggplot(data=efilter2,aes(x=Genre,y=Popularity))+geom_jitter(aes(color=DateYear))+geom_boxplot(alpha=.1)+
  labs(color="Year of Release")+ggtitle("Emo sub-genres by popularity")+scale_color_distiller(palette="Spectral",direction=1)


ggplot(data=data,aes(x=Danceability,y=Valence))+geom_point()+geom_smooth(fill=NA,color="red")

#spotify thinks the most danceable songs are somewhat sad

ggplot(data=data,aes(x=Valence,y=Energy))+geom_point(aes(color=BigGenre))+geom_smooth(method="lm",color="red")+
  ggtitle("Relationship Between Valence and Energy, all songs")+labs(color="'Big Genre'")

summary(lm(Energy ~ Valence, data=data))

#slope = .24032

ggplot(data=data,aes(x=Valence,y=Danceability))+geom_point(aes(color=BigGenre))+geom_smooth(method="lm",color="red")+
  scale_color_viridis_d(option="turbo")+ggtitle("Relationship Between Valence and Danceability, all songs")+labs(color="'Big Genre'")


ggplot(data=data,aes(x=Valence,y=Danceability))+geom_point(aes(color=BigGenre))+geom_smooth(method="lm",color="red")+
  ggtitle("Relationship Between Valence and Danceability, all songs")+labs(color="'Big Genre'")

summary(lm(Danceability ~ Valence, data=data))

#slope = .19206

toptendanceable<-top_n(data,10,Danceability)


#method 1 - table
write.table(toptendanceable)
write.csv(toptendanceable,"~/Downloads.csv", row.names = FALSE)

#method 2 - gt
toptendanceable[1:5]

gt(toptendanceable[1:5])

gt(top_n(data,-5,Valence)[c(1,3,7,14)])



