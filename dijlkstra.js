require('dotenv').config();

const mysql = require('./src/databaseManager').getInstance();

mysql.establishConnection().then(() => {
    mysql.queryPromisify('SELECT * FROM rides').then(rides => {
        const dijlkstra = (start, destination) => {
            /**
             * @type Set<number>
             */
            let visitedNodes = new Set();
            /**
             * @type Map<number, number>
             */
            let previousNode = new Map();

            const findNeighbours = node => {
                filteredRides = rides.filter(x => x.start_location_id === node);

                filteredRides = filteredRides.map(x => x.destination_location_id);
                console.log('neighbours', filteredRides);

                return filteredRides;
            };

            const dijlkstra2 = start => {
                console.log('blub', start);
                visitedNodes.add(start);

                for (node of findNeighbours(start)) {
                    if (!visitedNodes.has(node)) previousNode.set(node, start);

                    if (node === destination) {
                        console.log('test')
                        let path = [];
                        while (previousNode.get(node)) {
                            path.push(node);
                            node = previousNode.get(node);
                        }
                        return path.reverse();
                    } else if (visitedNodes.has(node)) {
                        continue;
                    }

                    let result = dijlkstra2(node);

                    if (result === null) {
                        continue;
                    } else {
                        return result;
                    }
                }

                return null;
            }

            return dijlkstra2(start);
        };

        console.log(dijlkstra(5, 95));
        process.exit();

        module.exports = dijlkstra;
    });
});
