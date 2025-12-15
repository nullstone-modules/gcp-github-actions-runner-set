locals {
  // This is based off the default template for containerMode.type=kubernetes
  // See https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set/values.yaml#L366
  //
  //   spec:
  //     containers:
  //     - name: runner
  //       image: ghcr.io/actions/actions-runner:latest
  //       command: ["/home/runner/run.sh"]
  //       env:
  //         - name: ACTIONS_RUNNER_CONTAINER_HOOKS
  //           value: /home/runner/k8s/index.js
  //         - name: ACTIONS_RUNNER_POD_NAME
  //           valueFrom:
  //             fieldRef:
  //               fieldPath: metadata.name
  //         - name: ACTIONS_RUNNER_REQUIRE_JOB_CONTAINER
  //           value: "true"
  //       volumeMounts:
  //         - name: work
  //           mountPath: /home/runner/_work
  //     volumes:
  //       - name: work
  //         ephemeral:
  //           volumeClaimTemplate:
  //             spec:
  //               accessModes: [ "ReadWriteOnce" ]
  //               storageClassName: "local-path"
  //               resources:
  //                 requests:
  //                   storage: 1Gi
}
