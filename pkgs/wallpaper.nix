{
  pkgs,
  colorScheme,
  stdenv,
  writeTextFile,
  inkscape,
  envsubst,
  ...
}:
let
  c = colorScheme.palette;
in
stdenv.mkDerivation {
  name = "nix-colors-wallpaper-${colorScheme.slug}";
  src = writeTextFile {
    name = "template.svg";
    text = ''
      <?xml version="1.0" encoding="utf-8"?>
      <svg viewBox="0 0 508 285.75" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <defs>
          <linearGradient y2="515.97058" x2="282.26105" y1="338.62445" x1="213.95642" gradientTransform="translate(983.36076,601.38885)" gradientUnits="userSpaceOnUse" id="linearGradient5855" xlink:href="#linearGradient5960"/>
          <linearGradient id="linearGradient5960">
            <stop id="stop5962" offset="0" style="stop-color:#637ddf;stop-opacity:1"/>
            <stop style="stop-color:#649afa;stop-opacity:1" offset="0.2317" id="stop5964"/>
            <stop id="stop5966" offset="1" style="stop-color:#719efa;stop-opacity:1"/>
          </linearGradient>
        </defs>
        <rect width="510" height="286" style="stroke: rgb(255, 255, 255); stroke-width: 0px; fill: #$base00;" transform="matrix(1, 0, 0, 1, -1.4210854715202004e-14, -7.105427357601002e-15)"/>
        <g id="layer7" style="display:none" transform="matrix(1, 0, 0, 1, 4.047286033630357, -107.66201782226562)">
          <rect transform="translate(-132.5822,958.04022)" style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="rect5389" width="1543.4283" height="483.7439" x="132.5822" y="-957.77832"/>
        </g>
        <g id="layer5" style="display:none;opacity:0.51599995" transform="matrix(1, 0, 0, 1, -128.5347137451172, 850.3779296875)">
          <rect y="-957.77832" x="132.5822" height="483.7439" width="1543.4283" id="rect5350" style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#d4d4d4;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"/>
          <rect style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#9b9b9b;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="rect5346" width="1496.443" height="435.68069" x="155.77646" y="-933.38721"/>
          <rect y="-851.65918" x="159.02695" height="272.58423" width="1492.5731" id="rect5348" style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#848484;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"/>
        </g>
        <g id="layer6" style="display:none" transform="matrix(1, 0, 0, 1, -128.5347137451172, 850.3779296875)">
          <rect y="-958.02759" x="132.65129" height="484.30399" width="550.41602" id="rect5379" style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#5c201e;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"/>
          <rect style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#c24a46;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="rect5372" width="501.94415" height="434.30405" x="156.12303" y="-933.02759"/>
          <rect style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#d98d8a;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="rect5381" width="24.939611" height="24.939611" x="658.02826" y="-958.04022"/>
        </g>
        <g id="layer1" style="display: inline;" transform="matrix(0.15441299974918365, 0, 0, 0.15441299974918365, 195.40130615234375, 255.90766906738276)">
          <path style="color: rgb(0, 0, 0); clip-rule: nonzero; display: inline; overflow: visible; visibility: visible; opacity: 1; isolation: auto; mix-blend-mode: normal; color-interpolation: srgb; color-interpolation-filters: linearrgb; fill-opacity: 1; fill-rule: evenodd; stroke: none; stroke-width: 3; stroke-linecap: butt; stroke-linejoin: round; stroke-miterlimit: 4; stroke-dasharray: none; stroke-dashoffset: 0; stroke-opacity: 1; color-rendering: auto; image-rendering: auto; shape-rendering: auto; text-rendering: auto; fill: #$base0A;" d="m 309.40365,-710.2521 122.19683,211.6751 -56.15706,0.5268 -32.6236,-56.8692 -32.85645,56.5653 -27.90237,-0.011 -14.29086,-24.6896 46.81047,-80.4902 -33.22946,-57.8256 z" id="path4861"/>
          <path style="color: rgb(0, 0, 0); clip-rule: nonzero; display: inline; overflow: visible; visibility: visible; opacity: 1; isolation: auto; mix-blend-mode: normal; color-interpolation: srgb; color-interpolation-filters: linearrgb; fill-opacity: 1; fill-rule: evenodd; stroke: none; stroke-width: 3; stroke-linecap: butt; stroke-linejoin: round; stroke-miterlimit: 4; stroke-dasharray: none; stroke-dashoffset: 0; stroke-opacity: 1; color-rendering: auto; image-rendering: auto; shape-rendering: auto; text-rendering: auto; fill: #$base0C;" d="m 353.50926,-797.4433 -122.21756,211.6631 -28.53477,-48.37 32.93839,-56.6875 -65.41521,-0.1719 -13.9414,-24.1698 14.23637,-24.721 93.11177,0.2939 33.46371,-57.6903 z" id="use4863"/>
          <path style="color: rgb(0, 0, 0); clip-rule: nonzero; display: inline; overflow: visible; visibility: visible; opacity: 1; isolation: auto; mix-blend-mode: normal; color-interpolation: srgb; color-interpolation-filters: linearrgb; fill-opacity: 1; fill-rule: evenodd; stroke: none; stroke-linecap: butt; stroke-linejoin: round; stroke-miterlimit: 4; stroke-dasharray: none; stroke-dashoffset: 0; stroke-opacity: 1; color-rendering: auto; image-rendering: auto; shape-rendering: auto; text-rendering: auto; stroke-width: 0px; fill: #$base0C;" d="m 362.88537,-628.243 244.41439,0.012 -27.62229,48.8968 -65.56199,-0.1817 32.55876,56.7371 -13.96098,24.1585 -28.52722,0.032 -46.3013,-80.7841 -66.69317,-0.1353 z" id="use4865"/>
          <path style="color: rgb(0, 0, 0); clip-rule: nonzero; display: inline; overflow: visible; visibility: visible; opacity: 1; isolation: auto; mix-blend-mode: normal; color-interpolation: srgb; color-interpolation-filters: linearrgb; fill-opacity: 1; fill-rule: evenodd; stroke: none; stroke-width: 3; stroke-linecap: butt; stroke-linejoin: round; stroke-miterlimit: 4; stroke-dasharray: none; stroke-dashoffset: 0; stroke-opacity: 1; color-rendering: auto; image-rendering: auto; shape-rendering: auto; text-rendering: auto; fill: #$base0C;" d="m 505.14318,-720.9886 -122.19683,-211.6751 56.15706,-0.5268 32.6236,56.8692 32.85645,-56.5653 27.90237,0.011 14.29086,24.6896 -46.81047,80.4902 33.22946,57.8256 z" id="use4867"/>
          <path id="use4875" d="m 451.3364,-803.53264 -244.4144,-0.012 27.62229,-48.89685 65.56199,0.18175 -32.55875,-56.73717 13.96097,-24.15851 28.52722,-0.0315 46.3013,80.78414 66.69317,0.13524 z" style="color: rgb(0, 0, 0); clip-rule: nonzero; display: inline; overflow: visible; visibility: visible; opacity: 1; isolation: auto; mix-blend-mode: normal; color-interpolation: srgb; color-interpolation-filters: linearrgb; fill-opacity: 1; fill-rule: evenodd; stroke: none; stroke-width: 3; stroke-linecap: butt; stroke-linejoin: round; stroke-miterlimit: 4; stroke-dasharray: none; stroke-dashoffset: 0; stroke-opacity: 1; color-rendering: auto; image-rendering: auto; shape-rendering: auto; text-rendering: auto; fill: #$base0A;"/>
          <path id="use4877" d="m 460.87178,-633.8425 122.21757,-211.66304 28.53477,48.37003 -32.93839,56.68751 65.4152,0.1718 13.9414,24.1698 -14.23636,24.7211 -93.11177,-0.294 -33.46371,57.6904 z" style="color: rgb(0, 0, 0); clip-rule: nonzero; display: inline; overflow: visible; visibility: visible; opacity: 1; isolation: auto; mix-blend-mode: normal; color-interpolation: srgb; color-interpolation-filters: linearrgb; fill-opacity: 1; fill-rule: evenodd; stroke: none; stroke-linecap: butt; stroke-linejoin: round; stroke-miterlimit: 4; stroke-dasharray: none; stroke-dashoffset: 0; stroke-opacity: 1; color-rendering: auto; image-rendering: auto; shape-rendering: auto; text-rendering: auto; fill: #$base0A; stroke-width: 0px;"/>
          <g id="layer2" style="display:none" transform="translate(72.039038,-1799.4476)">
            <path d="M 460.60629,594.72881 209.74183,594.7288 84.309616,377.4738 209.74185,160.21882 l 250.86446,1e-5 125.43222,217.255 z" id="path6032" style="color:#000000;display:inline;overflow:visible;visibility:visible;opacity:0.23600003;fill:#4e4d52;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate"/>
            <path transform="translate(0,-308.26772)" style="color:#000000;display:inline;overflow:visible;visibility:visible;opacity:1;fill:#4e4d52;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate" id="path5875" d="m 385.59154,773.06721 -100.83495,0 -50.41747,-87.32564 50.41748,-87.32563 100.83495,10e-6 50.41748,87.32563 z"/>
            <path transform="translate(0,-308.26772)" id="path5851" d="m 1216.5591,938.53395 123.0545,228.14035 -42.6807,-1.2616 -43.4823,-79.7725 -39.6506,80.3267 -32.6875,-19.7984 53.4737,-100.2848 -37.1157,-73.88955 z" style="fill:url(#linearGradient5855);fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"/>
            <rect style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:0.41499999;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#c53a3a;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="rect5884" width="48.834862" height="226.22897" x="-34.74221" y="446.17056" transform="matrix(0.8660254,-0.5,0.5,0.8660254,0,0)"/>
            <path transform="translate(0,-308.26772)" style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:0.50899999;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="path3428" d="m 251.98568,878.63831 -14.02447,24.29109 h -28.04894 l -14.02447,-24.29109 14.02447,-24.2911 h 28.04894 z"/>
            <rect style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:0.41499999;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#c53a3a;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="use4252" width="48.834862" height="226.22897" x="-34.74221" y="446.17056" transform="matrix(0.866025447845459, 0.5000000763159278, -0.5000000763159278, 0.866025447845459, 558.0263671875, 12.372991561889648)"/>
            <rect style="color:#000000;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#000000;fill-opacity:0.6507937;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" id="rect4254" width="5.3947482" height="115.12564" x="545.71014" y="467.07007" transform="matrix(0.8660254,0.5,-0.5,0.8660254,0,-308.26772)"/>
          </g>
        </g>
      </svg>
    '';
  };
  buildInputs = [
    inkscape
    envsubst
  ];
  unpackPhase = "true";
  buildPhase = ''
    export base00=${c.base00}
    export base01=${c.base01}
    export base02=${c.base02}
    export base03=${c.base03}
    export base04=${c.base04}
    export base05=${c.base05}
    export base06=${c.base06}
    export base07=${c.base07}
    export base08=${c.base08}
    export base09=${c.base09}
    export base0A=${c.base0A}
    export base0B=${c.base0B}
    export base0C=${c.base0C}
    export base0D=${c.base0D}
    export base0E=${c.base0E}
    export base0F=${c.base0F}
    envsubst < $src | inkscape -p -w 1920 -h 1080 -o ./wallpaper.png
  '';
  installPhase = ''
    cp wallpaper.png $out
  '';
}
