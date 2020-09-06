# Political reporting of german online news 

- Check the current slides [here](https://franziloew.github.io/news_paper/rd_cosdist.html)

In recent years, the media and their role in the perception and decision of individuals in the political context have been increasingly subject to criticism. Terms such as "fake news" or "quality journalism" are currently part of almost every debate regarding the role of the media. Critics accuse the media of reporting biased on certain parties or political events and thus influencing the political consciousness of voters. This raises the unavoidable question of what biased reporting actually means or, on the contrary, what objective reporting is and if this is even possible. A journalist who writes an article about a certain topic puts rough facts (e.g. figures on economic indicators) into a context, such that each article is shaped by the subjectivity of this journalist. Similarly, an editor of a media outlet has to select the topics to be discussed in the medium from a large pool of reports. Thus, to a certain extent, media is always filtered by journalists' perceptions and editorial decisions. 

A legitimate question, however, could be which factors or incentives lead to the selection or deselection of certain topics. On the one hand, one could assume that editors select the topics and articles that correspond to their own political views. A profit-maximizing editor, on the other hand, would tend to adapt the selection to readers' preferences. (Some populist voices would even claim that - at least the so called "mainstream media" - is controlled by the government.) 

In order to answer these and other media-related questions in the political context, quantifying the content of media is essential. In other words, what features can be used to measure the content of, for example, an online article? The literature of communication science, for example, often uses visibility (how often political actors appear in the media) or tonality (how they are evaluated) in this regard. In addition to these actor-based approaches, there are also more issue-based approaches to be found in communication science as well as in other disciplines. In this case, the contents or the language used by media are compared with the contents or the language used by political actors in order to identify whether political actors are able to place their own policy positions in the media using their own language. Leading studies from economic literature, for example, examine how often a newspaper quotes the same think tanks ([Groseclose & Milyo, 2005](https://www.jstor.org/stable/25098770?seq=1#metadata_info_tab_contents)) or uses the same language ([Gentzkow & Shapiro, 2010](https://onlinelibrary.wiley.com/doi/abs/10.3982/ECTA7195)) as members of Congress. 

In the present paper the slant-index (or ideological score) of an online newspaper is calculated by comparing the topics discussed in such newspapers with the topics discussed in parties press releases similar to [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364). However, in contrast to [Eberl, 2017](https://journals.sagepub.com/doi/abs/10.1177/0093650215614364) a machine learning approach is used to analyze a text dataset containing nearly 12.000 online news articles from seven major news provider dated from June 1, 2017 to March 1, 2018 as well as over 1.900 press releases of the parties in the german "Bundestag". As the German federal elections took place on 24th of September 2017 and the formation of the government has taken up a period of about five months, the articles considered inform their readers about both the election promises of the parties (before the election) and the coalition talks (after the election). To discover the latent topics in the corpus of text data, the structural topic model (STM) developed by [Roberts et al., 2013](https://scholar.princeton.edu/files/bstewart/files/stmnips2013.pdf) is applied. The STM is an unsupervised machine learning approach that models topics as multinomial distributions of words and documents (as a synonym for news articles) as multinomial distributions of topics, allowing the incorporation of external variables that affect both, topical content and topical prevalence. The results of the generative process of the STM are two posterior distributions: One for the topic prevalence in a document (what is the article or press release about?) and one for the content of a topic (what is the topic about?). In the next step the topics addressed in campaign communication (i.e., the party agenda) are compared with the topics the parties address in media coverage (i.e., the mediated party agenda). The results of this analysis are then compared with data on the political orientation of consumers in order to evaluate whether there may be a link between consumer preferences and the slant-index of a medium. 

The use of online news as data input accurately reflects the changed conditions in the news market as the importance of the internet as a source of information for political topics has grown strongly in recent years. Even though television remains the most widely used source of news in Germany (2018: 74%), numbers watching continue to decline while use of the internet for news has grown significantly in the last year (+5%, 2018: 65%) ([Reuters Institute Digital News Survey](http://www.digitalnewsreport.org/about-us-2018/)). This trend has as strong effect on the market for media content as neither supply nor demand is tied to specific times and can adapt to events in real time. Users can consume their preferred news sources at any time and providers can adapt their offerings to events in real time without waiting for the next issue or TV show.

The research contribution of this paper is twofold: First, a new method for the calculation of the slant-index is presented that allows an extensive content analyses of newspaper coverage and party press releases and at the same time reduces human induced bias and makes research more traceable and comparable. In addition, a new dataset of online news is used, which has a significant relation to the current discussion of the media in the political context.

The remaining course of the paper is as follows: The following section provides an overview of the related literature. Section 3 gives an introduction to the political trends within the analyzed time span (June 2017 to March 2018). The data used to conduct the model is described in section 4. Section 5 explains the generative process of the structural topic model as well as the selected parameters to run the model. The empirical analysis is conducted in section 6. 

## 2. Literature review

## 3. [Background on the federal election in Germany (2017)](https://franziloew.github.io/news_paper/scrape_polls.html)

![](/figs/polldata.png)

## 4. Data 

![](/figs/data.png)

- [Online newspaper articles](https://franziloew.github.io/news_paper/03a_newsData.html)

- [Press releases](https://franziloew.github.io/news_paper/03b_pressReleases.html)

## 5. Measuring Slant (Structural topic model)

## 6. Emprical results

- [Agenda correlation](https://franziloew.github.io/news_paper/agenda.html)

![](/figs/radarchart.png)

- [Political orientation](https://franziloew.github.io/news_paper/reuters.html)

![](/figs/reuters.png)
