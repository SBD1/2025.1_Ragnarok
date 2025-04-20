import 'dotenv/config';
import chalk from 'chalk';
import pg from 'pg';

const { Client } = pg;

const client = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

client.connect()
  .then(() => {
    console.log(chalk.green('✅ Sucesso!'));
    return client.end();
  })
  .catch(err => {
    console.error(chalk.red('❌ Erro.'), err.message);
  });
