
# Introduction 

On January 1, 2024, I set out on a year-long project. Every new year, [r/dataisbeautiful](https://www.reddit.com/r/dataisbeautiful/) users would post the culmination of their tracking of some aspect of their lives throughout an entire year, whether that be crying or drinking or average mood level. My idea was to create a playlist that I would add one song to each day of the year, to end up with a 366 (leap year!) song playlist that I could reflect on when the year is over. Songs were chosen if they were related to a day’s actions, such as “Come Sail Away” when I went on a cruise, listened to on repeat, or introduced to me by another, among other reasons. Overall, I felt this was a more reflective look at my year in listening than Spotify’s Wrapped, because of increases in both breadth and depth that it allowed.

  

Throughout the year, I really took a step in listening to genres that were not rap. Unfortunately for my friends and family, this was in large part due to my newfound love for “Midwest Emo” (a convoluted genre, but generally used to describe emo music with indie rock/math rock influence) bands such as Modern Baseball and saturdays at your place. Having been chastised for how sad, whiny, and generally unlistenable my music was, I set out to analyze my year’s listening.

  

At the end of the year, I had newly acquired R data analysis and visualization skills, and wanted to put them to work. My goal for this project was to navigate a dataset with a variety of variables, work on research skills such as recoding variables and cleaning datasets, and practice data visualization with ggplot and related functions.

  
All code can be found on [github](https://github.com/tobywinick/spotify/blob/main/spotify.R).

# Tools
- R/RStudio
- Spotify API
- Exportify
- Everynoise
  

# Data

  

I used [Exportify](https://exportify.net/) to turn the playlist into a CSV, which included some key categories that Spotify hides from users but uses in its music recommendation/sorting (all are measured on a scale of 0-1). I ended up with 345 songs, having forgotten some days along the year, and having to remove one song that was uploaded from my local files, so Spotify had no data about it (sorry, Pictures of You by Catnaps). Here is how Spotify describes them:

  

-   **Acousticness**: This value describes how acoustic a song is. A score of 1.0 means the song is most likely to be an acoustic one.
    
-   **Energy**: “(energy) represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy”.
    
-   **Danceability**: “Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable”.
    
-   **Valence**: “A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry)”.
    

  

I selected these four due to their relevance to measuring “sadness,” and the general stereotyping of Midwest Emo musicians to [use acoustic guitars](https://uk.pinterest.com/pin/midwest-emo-folk-emoji--612137774387627218/). Moreover, I didn’t think that most of my playlist was very acoustic. Most acoustic songs to me are slow and sad, and I didn’t really think of my playlist that way.

  
  

The last important categories were “Big Genre” and Genre. Spotify automatically assigns artists genres from a [gigantic](https://www.polyesterzine.com/features/spotify-daylist-ai-playlist-title) range. However, when sorting artists I faced three main problems.

  

1.  *Many artists are in multiple genres*. To solve this, I listed the first one that the artist was grouped under, as it would determine their primary genre, and often the most popular.
    
2.  *Some artists don’t have a genre*. At first, I thought this was symptomatic of smaller artists being undercovered when I exported the files, but even bigger artists such as Laufey were absent for some reason. To alleviate this, I enlisted [everynoise](http://everynoise.com), which allows the user to look up any artist in the world and find what categories Spotify uses for their music. If Spotify hasn’t covered an artist, they suggest categories based on similar artists.
    
3.  *There is, in fact, an absurd amount of genres*. When I finished these first two steps, I was still faced with almost **90(!) genres on 345 songs**. Indie Rock, Alternative Rock, Rock, and Indie are all different genres in Spotify’s eyes. For this reason, I developed the factored variable “BigGenre,” sorting these small genres into bigger categories that most represented my music. These were **Emo, Indie, New Wave, Pop, Rap, Rock, and Other**. “Other” included a range of songs from jazz, musical theater, and comedy. Because it would be very difficult to plot 80+ Genres, much of the plotting is done with the “Big Genre” variable.
    

  

# Analysis

  

First, I looked at the means of the measures Spotify provided across my playlist.

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdVdicF0mlhWpUxFeXdYAcIX3lPcQueZ4DWY3XfgIz8tNI3ndl1ZROrxNFfEN6zStl6kfDF3LRsMnIJTDf2SCsYeZh_xq6pfzo9kzMJmiGuG6SKPX-34z80dCbnvnmDRph6Q097sg?key=eBRGzX71RG5sf91yVSujMwo-)

  

Overall, this playlist is slightly above average on danceability, energy, and valence. Acousticness remains quite low, which was only surprising to me at first. Upon reflection, I think this is because I am not a big listener of folk or acoustic pop or indie. Many of my favorite Midwest Emo songs are still played with electric guitars (and drums and bass guitars). I was pretty proud of these results, especially on valence and energy. I would anticipate that many emo songs would be high energy, but low valence and that does not seem to be the case.

  

To verify this, I analyzed the means of each category, first looking at just Midwest Emo songs, and then looking at the playlist without those songs to see how they were affecting the averages.

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdBhjyfXAQGCQcoKV30tLprcaNvGoS_1Bn1y9sq3RnJBck9MBGY6EoD0-8vcDMx3HQPnS6MrHIRuVxOFqAuVCtragLl4GqeabMhaiSc55UbeFhWpCh8KM2XckQfFLhQf0rpgbjA?key=eBRGzX71RG5sf91yVSujMwo-)

  



![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcuIrOCRKV5aF1Urh6hdkPu1jh0chUu6mRtRKf_XH2OJaJhGN4TwrFDMavJAomcKHn_HT5khAex9Ww8TvhieTLSCkptl8bns_ftiVZX4MiAIjljoqJ8LzZVqteBd66BARb3wVvw?key=eBRGzX71RG5sf91yVSujMwo-)

  
  

Midwest Emo songs do score higher than the playlist’s average on Energy, which I consider a success in proving that these songs maybe aren’t as boring as the rest of my music taste. Moreover, they are almost the exact same in Valence. It’s almost more concerning that my whole playlist has a middling Valence score that seemingly can’t be remedied by this. It’s possible that I just listen to generally sadder or angrier music across all genres.

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdahR9g55Shy-1Z88R9Id4k2re8YnBfG3O4qu5vseG4-jSoIM_2Yg-g2fBwBbGZBKwMmKNq4_K3FxH3MTw77QG_dbvzKNJSNEUB67j65WWg70KxXt5zhnHq4ANJzfJqOiH-pDO1?key=eBRGzX71RG5sf91yVSujMwo-)

The 5 least valent songs exhibit a mix between sadder indie music and angry rap music. No emo songs are present.

  

First, I wanted to check the relationship between some of these measures. Valence seemed to be exactly what I was looking for, as it directly measures positivity of a track. I began by measuring it against Energy and Danceability.

  
  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfEiDeNHP-mEWHrZ7iVX2wbCfw9xbdxqF7RZT45UTrf_0JnjZW0A1J3yLqi81JEWrBhLptn24QnflSDKWTAlkFp4h-lsbXd210N5nzru5wD2cQ9j-0-W936Y8jMXSGI6wme0d9Hdw?key=eBRGzX71RG5sf91yVSujMwo-)

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeZLK7xD_cNliNJ5mAp2XWMpTmuxt4sRG03GBUmxX2DgFeHPltTVklGuRxsa3gXFlFZtBHIpOHVfd25jdPXn5uhelAvenSAS291sSxySw--6kVwnBqc7LfyXO9QLAZIGu6cuQMWdQ?key=eBRGzX71RG5sf91yVSujMwo-)

  
  
  

Both of these relationships demonstrate upward trends. More positive songs tend to have higher energy and danceability. For Danceability, the correlation coefficient is roughly 0.192, and for Energy it is roughly 0.24. Although there is a positive correlation for both, the graphs demonstrate immense variance. Indeed, the slope of the lines of best fit are close to 0, so the correlation is loose at best.

  

I also note that towards the top level, Energy exhibits much more variance than Danceability. I was surprised to find out that Spotify listed almost all of the most danceable songs in my playlist as rap songs, even as their valence varied greatly. Many emo, pop, and rock songs have high energy but did not show high danceability. I believe this is because rap songs exhibit high beat strength, stability, and tempo, all of which are key contributors to the metric. Still, their danceability metric could have included popularity or ability to be sung along with, though I’m not sure how that could be accomplished.

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXduHeEZ8PlKTBgbnqDr5ihINiNn3ofiD_nujzclOclFCDM3RfswTygpyClwieIzwqeDDFMsP4ot0A8BbeTrSUEL8XE4E1YPHaruepDbxMumj_AaKLrL6A7M0tKE0ZXZGwq8FcuF?key=eBRGzX71RG5sf91yVSujMwo-)

  

The top ten most Danceable songs are all rap songs, though their valence varies greatly.

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXca6CWiMYR0qPhgcCvk3ZxKf_On4jqEVDRP4TJeDs19f2M3XS-hzzml9XPDBbWPTGUPAsHmJ2M0WA_WDpMnANfg74uEMchuRFgZla6pViBGoBelVAllKJMPIMdCzaOQEw0ghsq3Pg?key=eBRGzX71RG5sf91yVSujMwo-)

Unfortunately, among the 30 least danceable songs (roughly the bottom 10%), half are emo

  
  
  
  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcLNWHyYnc0Z8kgcmZtt2fQFE7trbQhDN1MUpOO9n5Iu4C311XnR2q4p3tVAi3mMNFOCVAFcPjHXQjdYtGclxSEGMnshSKkE5fkDlGx-Pw7f7AN7zNwvjcAb7QxxCIuPoe-NK8SKQ?key=eBRGzX71RG5sf91yVSujMwo-)

  

A final aspect that I wanted to explore was the overall popularity rating. I haven’t discussed it up until this point, but Spotify’s popularity rating is based on an algorithm that factors in the number of streams, recency of play counts, and listener engagement. This figure, unlike the others, changes over time, so it also offers a snapshot into the popularity of songs I listened to that were released in 2024 as they stood at the start of 2025.

  

It’s clear that while my overall music taste is pretty basic, emo scores the lowest by a significant amount on popularity. This isn’t unexpected, and I can take pride that my main genre is pretty niche (whether that is because no one actually likes it is another question). However, it is interesting that most of the newer songs are less popular. When examining this, I noticed that because my big group of “emo” included pop punk, punk, and regular emo as they are all adjacent to the newer music I listen to, these songs were often by much more famous artists. Indeed, the most popular “emo” songs include songs like “American Idiot” and “Brain Stew” by Green Day (classified as a punk band), “I Miss You” and “What’s My Age Again?” by blink-182 (pop punk), and “Welcome to the Black Parade” by My Chemical Romance (emo). Comparing the style and legacy of these songs to some of the modern emo acts on the playlist resulted in greatly different popularities.

  

When looking at just emo songs that were classified as midwest emo, the mean popularity was roughly 0.41. For the overall set, the average was  about 0.45. But because of their prevalence in the emo category, they managed to drag down a rating that, when filtering emo songs that were not midwest emo, was 0.65. This is a substantial difference that would make this category much more comparable to other genres in the list.

  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfp7Gqis03Tb-4wuaX7HCEfVogICe_c8cP3SN5W4DJBWiQXAtnKX0uasnArBLeGSzmrQpFBzIfSlJQfIyKHdwaf7LZJ8ynhfxORgAz_AHUKdNkziIMpHWfV4cPQexTJAVmut3Sk6Q?key=eBRGzX71RG5sf91yVSujMwo-)

  

Although there is a much smaller sample size for them, each other sub-genre has a notably higher popularity than Midwest Emo. Still the highest midwest emo songs are similarly popular to those other sub-genres. One possible reason is that because this is the most extensive sub-genre I listen to, so I have ventured further into “deep cuts.” It is also clearer to see on this plot that punk, pop punk, and emo have older songs than Midwest Emo.

  
  

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdFzhe1jyZ-OwZHLGI9TlNahBLZDL23-D1up99kzVzf5vWQNvoWza6wnj56anTeGoZJjXw9Xw0NVYjiQL_7WHUrmdmXJiGt2lj7pDJSwakiUH5bhdyBahhuJuXo9RHOXF2-Z_4AGw?key=eBRGzX71RG5sf91yVSujMwo-)

  

In an overall annual analysis, the 2010s are the most common decade for songs in the playlist, decreasing over time. The 2020s have less, but probably because the decade is only halfway done. Rap, indie, and emo songs are more recent, while rock (and “other”) show a steady distribution over time.

  

# Conclusion/Potential improvements

  

Overall, this was a great exercise that gave me greater insight to my music taste last year and allowed me to expand my knowledge of R programming and data visualization. In the future, I might compare my playlist to a friend’s in order to see if their criticism of my playlist is justified on the metrics spotify provides. I also think that this was influenced by some specifics of Spotify’s calculation that I don’t necessarily agree with, such as danceability heavily favoring rap songs or valence being pretty neutral on most emo songs. Still, this analysis allowed me to examine what criteria Spotify might use to recommend new music to me.
