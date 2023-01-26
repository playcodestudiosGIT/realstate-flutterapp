class Recomendaciones {
  final String name, image, source, text;

  Recomendaciones({required this.name, required this.image, required this.source, required this.text});
}

final List<Recomendaciones> demoRecomendaciones = [
  Recomendaciones(
    name: "Simeon Cox",
    image: "/proyectos/project-01.jpg",
    source: "Skyscrapers",
    text: "Lorem ipsum dolor sit amet, facilis admodum officiis est te,",
  ),
  Recomendaciones(
    name: "Jake Hooper",
    image: "/proyectos/project-02.jpg",
    source: "Offices",
    text: "Enim antiopam similique ut vis. Veri repudiare per cu. ad doming",
  ),
  Recomendaciones(
    name: "Eden Welch",
    image: "/proyectos/project-03.jpg",
    source: "Green House",
    text: "Veri repudiare per cu. Et labitur maiorum officiis eos, ad doming m",
  ),
  Recomendaciones(
    name: "Alexandra Rush",
    image: "/proyectos/project-04.jpg",
    source: "Modern House",
    text:
        "Vix ad erant choro. Eligendi molestiae in quo, id equidem expetenda m",
  ),
];
