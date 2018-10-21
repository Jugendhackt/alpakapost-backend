const mysql = require('./src/databaseManager').getInstance();

const dijlkstra = (start, destination) => {
    return mysql.establishConnection().then(() => {
        return mysql.queryPromisify('SELECT * FROM rides')
    }).then(rides => {
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

            return filteredRides;
        };

        const dijlkstra2 = start => {
            visitedNodes.add(start);

            for (node of findNeighbours(start)) {
                if (!visitedNodes.has(node)) previousNode.set(node, start);

                if (node === destination) {
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
                    return Promise.resolve(result);
                }
            }

            return Promise.resolve(null);
        }

        return dijlkstra2(start);
    });
};

module.exports = dijlkstra;