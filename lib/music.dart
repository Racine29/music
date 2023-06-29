class Music {
  String cover;
  String cd;

  Music({required this.cover, required this.cd});
}

List<Music> musics = List.generate(
    5,
    (index) =>
        Music(cover: "asset/${index + 1}.png", cd: "asset/${index + 1}-cd.png"))
  ..addAll(List.generate(
      5,
      (index) => Music(
          cover: "asset/${index + 1}.png", cd: "asset/${index + 1}-cd.png")));
