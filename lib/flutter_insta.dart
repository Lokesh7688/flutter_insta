import 'dart:convert';

import 'package:http/http.dart' as http;

class FlutterInsta {
  String url = "https://www.instagram.com/";
  String _followers, _following, _website, _bio, _imgurl;

  //Download reels video
  Future<String> downloadReels(String link) async {
    var downloadURL = await http.get(link + "/?__a=1");
    var data = json.decode(downloadURL.body);
    var graphql = data['graphql'];
    var shortcode_media = graphql['shortcode_media'];
    var video_url = shortcode_media['video_url'];
    return video_url; // return download link
  }

  //get profile details
  Future<void> getProfileData(String username) async {
    var res = await http.get(Uri.encodeFull(url + username + "/?__a=1"));
    var data = json.decode(res.body);
    var graphql = data['graphql'];
    var user = graphql['user'];
    var biography = user['biography'];
    _bio = biography;
    var myfollowers = user['edge_followed_by'];
    var myfollowing = user['edge_follow'];
    _followers = myfollowers['count'].toString();
    _following = myfollowing['count'].toString();
    _website = user['external_url'];
    _imgurl = user['profile_pic_url_hd'];
  }

  String get followers => _followers;

  get following => _following;

  get website => _website;

  get bio => _bio;

  get imgurl => _imgurl;
}
