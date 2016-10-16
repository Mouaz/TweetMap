package jersey.getting.started;

public class SimpleTweet {

	String userName;
	String content;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLon() {
		return lon;
	}
	public void setLon(String lon) {
		this.lon = lon;
	}
	String lat;
	String lon;
	public SimpleTweet(String userName,String content, String lat, String lon){
		this.userName = userName;
		this.content = content;
		this.lat = lat;
		this.lon = lon;
	}
	
	public String toString(){
		return this.userName+", "+this.content+", "+this.lat+", "+this.lon+", ";
	}
}
