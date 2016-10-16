package jersey.getting.started;

import java.util.ArrayList;

import twitter4j.GeoLocation;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class Fetcher {

	private static final String TWITTER_CONSUMER_KEY = "D5enayNK7I1D4sqtuyvnSIDvg";
	private static final String TWITTER_SECRET_KEY = "T1PJWKevW0gEmCg0l093y2ewmpG2pIKS3ajjiNIzfhwHzCCMO8";
	private static final String TWITTER_ACCESS_TOKEN = "349954211-cn9rE3y6AoIn7vol8Z8jFDb5xDCdtkwJlMngtWPT";
	private static final String TWITTER_ACCESS_TOKEN_SECRET = "eHf8ipjXQiwCdHEzu9S3VVOva97tUVp16SZaQnTodnD0I";

	/**
	 * method name: getTweets
	 * input: keyword as string
	 * output: Arraylist of type<SimpleTweet>
	 */
	public static ArrayList<SimpleTweet> getTweets(String keyword, int count){
		ConfigurationBuilder cb = new ConfigurationBuilder();
    	cb.setDebugEnabled(true)
    	  .setOAuthConsumerKey(TWITTER_CONSUMER_KEY)
    	  .setOAuthConsumerSecret(TWITTER_SECRET_KEY)
    	  .setOAuthAccessToken(TWITTER_ACCESS_TOKEN)
    	  .setOAuthAccessTokenSecret(TWITTER_ACCESS_TOKEN_SECRET);
    	
    	cb.setJSONStoreEnabled(true);
    	
    	
    	TwitterFactory tf = new TwitterFactory(cb.build());
    	Twitter twitter = tf.getInstance();
    	
    	
        Query query = new Query(keyword);
        query.setGeoCode(new GeoLocation(40.7127,74.0059), 10, Query.KILOMETERS);
        query.setLocale("en");
        query.setLang("en");
        int numberOfTweets = count;
        long lastID = Long.MAX_VALUE;
        ArrayList<Status> tweets = new ArrayList<Status>();
        /**
         * multiple queries as workaround in order to get more than 100 tweets per query
         */
        while (tweets.size () < numberOfTweets) {
          if (numberOfTweets - tweets.size() > 100)
            query.setCount(100);
          else 
            query.setCount(numberOfTweets - tweets.size());
          try {
            QueryResult result = twitter.search(query);
            tweets.addAll(result.getTweets());
            for (Status t: tweets) 
              if(t.getId() < lastID) lastID = t.getId();

          }

          catch (TwitterException te) {
        	  te.printStackTrace();
          }; 
          query.setMaxId(lastID-1);
        }
        ArrayList<SimpleTweet> sts = new ArrayList<SimpleTweet>();
        SimpleTweet st = null;
        for (int i = 0; i < tweets.size(); i++) {
        	Status t = (Status) tweets.get(i);
        	/*
        	 * Random coordinates added due to tweets have no coordinates (Twitter doesn't allow anymore exact location of tweets)
        	 */
        	st = new SimpleTweet(t.getUser().getScreenName(), t.getGeoLocation()+"", ((Math.random() * (180 - (-180))) - 180)+"", ((Math.random() * (180 - (-180))) - 180)+"");
       	 sts.add(st);
        }
        
        
        return sts;
	}
	
	/**
	 * some commented code that could be reused in the future "hopefully"
	 * tags: 	twitter4j
	 * 			streaming
	 * 			filter
	 */
/*
	StatusListener listener = new StatusListener(){
        public void onStatus(Status status) {
            System.out.println(status.getUser().getLocation() + " : " + status.getText());
        }
        public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {}
        public void onTrackLimitationNotice(int numberOfLimitedStatuses) {}
        public void onException(Exception ex) {
            ex.printStackTrace();
        }
		@Override
		public void onScrubGeo(long arg0, long arg1) {
			// TODO Auto-generated method stub
			
		}
		@Override
		public void onStallWarning(StallWarning arg0) {
			// TODO Auto-generated method stub
			
		}
    };
    
    TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
    
    
    FilterQuery filter = new FilterQuery();
    String keyword[]= {"vodafone"};

    double [][]location ={{-170, -90}, {180, 90}};

    filter.track(keyword);

    filter.locations(location);

    twitterStream.addListener(listener);
     sample() method internally creates a thread which manipulates TwitterStream and calls these adequate listener methods continuously.

    System.exit(0);
    twitterStream.filter(filter);
    
    twitterStream.sample();
    
	TwitterStream twitter = new TwitterStreamFactory(cb.build()).getInstance();
	twitter.addListener(listener);
	twitter.filter(filtro);
	
	for (Status status : result.getTweets()) {
//        	status.getGeoLocation().getLatitude()
        	if(status.getGeoLocation()!=null)
        		System.out.println(status.getGeoLocation());
        	 st = new SimpleTweet(status.getUser().getScreenName(), status.getText(), status.getUser().getLocation(), status.getUser().getLocation());
        	 sts.add(st);
            System.out.println(status.getUser().getLocation()+"@" + status.getUser().getScreenName() + ":" + status.getText());
        }
        System.out.println(TwitterObjectFactory.getRawJSON(result));
	*/
}
