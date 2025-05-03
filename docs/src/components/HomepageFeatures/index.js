import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Sobre o jogo',
    Svg: require('@site/static/img/logo.svg').default,
    description: (
      <>
      Em Ragnarok MUD, você é transportado para o vasto e místico mundo de Rune-Midgard, um universo repleto de aventuras, magia, monstros e batalhas épicas.
      </>
    ),
  },
  {
    title: 'Jogabilidade',
    Svg: require('@site/static/img/gaming.svg').default,
    description: (
      <>
        Você assume o papel de um aventureiro que desperta em uma terra dividida por guerras entre reinos, ameaçada por criaturas ancestrais e movida pela eterna busca por poder, conhecimento e redenção.
      </>
    ),
  },
  {
    title: 'MUD',
    Svg: require('@site/static/img/terminal.svg').default,
    description: (
      <>
        MUD (Multi-User Dungeon) é um tipo de jogo online interativo e colaborativo onde os jogadores exploram um ambiente virtual, geralmente de fantasia, em tempo real. É uma mistura de jogo de aventura e combate onde a comunicação entre os jogadores e a exploração do mundo acontecem através de comandos de texto.
      </>
    ),
  },
];

function Feature({ Svg, title, description }) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
